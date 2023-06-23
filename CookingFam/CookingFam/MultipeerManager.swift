import Foundation
import SwiftUI
import MultipeerConnectivity


class MultipeerManager: NSObject, ObservableObject {
    @Published var availablePeers: [MCPeerID] = []
    @Published var recvdInvite: Bool = false
    @Published var recvdInviteFrom: MCPeerID? = nil
    @Published var paired: Bool = false
    @Published var invitationHandler: ((Bool, MCSession?) -> Void)?
    
    @Published var receivedData: [String: [String]] = [:]
    
    
    private let serviceType = "cfService"
    private var myPeerID: MCPeerID
    
    public let serviceAdvertiser: MCNearbyServiceAdvertiser
    public let serviceBrowser: MCNearbyServiceBrowser
    public let session: MCSession
    
    

    init(username: String) {
        myPeerID = MCPeerID(displayName: UIDevice.current.name)
            
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        super.init()
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
                        
        serviceAdvertiser.startAdvertisingPeer()
        serviceBrowser.startBrowsingForPeers()
    }
    deinit {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
    }
    func send(dividedDirections: [String:[String]]) {
        if !session.connectedPeers.isEmpty {
            do {
                let encodedData = try JSONEncoder().encode(dividedDirections)
                try session.send(encodedData, toPeers: session.connectedPeers, with: .reliable)
                        
            } catch {
                print("Error sending: \(String(describing: error))")
            }
        }
    }
}

extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("ServiceAdvertiser didNotStartAdvertisingPeer: \(String(describing: error))")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        DispatchQueue.main.async {
            // Tell PairView to show the invitation alert
            self.recvdInvite = true
            // Give PairView the peerID of the peer who invited us
            self.recvdInviteFrom = peerID
            // Give PairView the `invitationHandler` so it can accept/deny the invitation
            self.invitationHandler = invitationHandler
        }
    }
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotPublish error: Error) {
        let nsError = error as NSError
        print("Failed to publish service. Error: \(nsError.localizedDescription)")
        print("Error code: \(nsError.code), domain: \(nsError.domain)")
    }

}

extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        //TODO: Tell the user something went wrong and try again
        print("ServiceBroser didNotStartBrowsingForPeers: \(String(describing: error))")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        // Add the peer to the list of available peers
        DispatchQueue.main.async {
            self.availablePeers.append(peerID)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // Remove lost peer from list of available peers
        DispatchQueue.main.async {
            self.availablePeers.removeAll(where: {
                $0 == peerID
            })
        }
    }
}

extension MultipeerManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("peer \(peerID) didChangeState: \(state.rawValue)")
        switch state {
        case MCSessionState.notConnected:
            // Peer disconnected
            DispatchQueue.main.async {
                self.paired = false
            }
            // Peer disconnected, start accepting invitaions again
            serviceAdvertiser.startAdvertisingPeer()
            break
        case MCSessionState.connected:
            // Peer connected
            DispatchQueue.main.async {
                self.paired = true
            }
            break
        default:
            // Peer connecting or something else
            DispatchQueue.main.async {
                self.paired = false
            }
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
           let decodedData = try JSONDecoder().decode([String: [String]].self, from: data)
           DispatchQueue.main.async {
               self.receivedData = decodedData
               print("YES RECEIVED")
               print(self.myPeerID)
               print(self.receivedData)
           }
        } catch {
           // Handle error while decoding data
           print("Error decoding data: \(error.localizedDescription)")
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("Receiving streams is not supported")
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
}
