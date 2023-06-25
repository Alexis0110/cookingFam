//
//  PairView.swift
//  CookingFam
//
//  Created by Alexis on 22.06.23.
//

import Foundation
import SwiftUI
import os

struct SendView: View {
    @Binding var dividedDirections : [String:[String]]
    @Binding var activeView: ActiveView
    
    @StateObject var session: MultipeerManager = MultipeerManager(username: "Manager")
    var logger = Logger()
        
    var body: some View {
            VStack {
                List(session.availablePeers, id: \.self) { peer in
                    // TODO: add info if connected to this user
                    Button(peer.displayName) {
                        session.serviceBrowser.invitePeer(peer, to: session.session, withContext: nil, timeout: 30)
                    }
                }
                Button("Start Cooking") {
                    print(dividedDirections)
                    activeView = .cooking
                }
                Button("Send directions") {
                    session.send(dividedDirections: dividedDirections)
                }.disabled(!session.paired)
            }
        }
    }

