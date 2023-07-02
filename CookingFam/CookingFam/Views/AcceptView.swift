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
    @Binding var activeRecipe: Recipe
    
    @StateObject var session: MultipeerManager = MultipeerManager(username: "Receiver")
        
    var body: some View {
            ZStack{
                BackButton(activeView: $activeView, prevView: .search)
                VStack {
                    Headline(text: "Recieve Directions")
                    Text("Waiting for the host to connect and send directions")
                    
                    Button(action: {
                        dividedDirections = session.receivedData
                        activeView = .cooking
                    }) {
                        ButtonText(text: !session.paired || session.receivedData.isEmpty ? "Waiting for directions" : "Start Cooking", disabled: !session.paired || session.receivedData.isEmpty)
                    }
                    .disabled(!session.paired || session.receivedData.isEmpty)
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
                .padding()
            }.onAppear(){
                
            }
        }
    }

