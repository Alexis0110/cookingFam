//
//  PairView.swift
//  CookingFam
//
//  Created by Alexis on 22.06.23.
//

import Foundation
import SwiftUI
import os

struct AcceptView: View {
    @Binding var dividedDirections : [String:[String]]
    @Binding var activeView: ActiveView
    
    @StateObject var session: MultipeerManager = MultipeerManager(username: "Receiver")
    var logger = Logger()
        
    var body: some View {
            HStack {
                Text("Waiting for your awesome cooking directions")
                Button("Start Cooking") {
                    print(dividedDirections)
                    dividedDirections = session.receivedData
                    
                    activeView = .cooking
                }.disabled(!(session.paired && dividedDirections == [:]))
                                        
            }
            .alert("Received an invite from \(session.recvdInviteFrom?.displayName ?? "ERR")!", isPresented: $session.recvdInvite) {
                Button("Accept cooking invite") {
                    if (session.invitationHandler != nil) {
                        session.invitationHandler!(true, session.session)
                    }
                }
                Button("Reject cooking invite") {
                    if (session.invitationHandler != nil) {
                        session.invitationHandler!(false, nil)
                    }
                }
            }
        }
    }

