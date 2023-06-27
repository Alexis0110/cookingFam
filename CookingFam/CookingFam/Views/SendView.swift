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
        
    var body: some View {
            ZStack{
                BackButton(activeView: $activeView, prevView: .search)
                VStack {
                    Headline(text: "Send Directions")
                    if session.availablePeers.isEmpty{
                        Text("Searching for devices to connect...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else{
                        List(session.availablePeers, id: \.self) { peer in
                            // TODO: add info if connected to this user
                            Button(action:{
                                session.serviceBrowser.invitePeer(peer, to: session.session, withContext: nil, timeout: 30)
                            }) {
                                Text(peer.displayName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                    .foregroundColor(Color("Text"))
                                    .background(Color("Background"))
                            }.listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .cornerRadius(10)
                        }
                        
                        .listStyle(PlainListStyle())
                    }
                    Button("Start Cooking"){
                        activeView = .cooking
                    }
                    .foregroundColor(Color("Text"))
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("Color3"))
                    .cornerRadius(10)
                    
                    Button("Send directions"){
                        session.send(dividedDirections: dividedDirections)
                    }
                    .foregroundColor(Color("Text"))
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(!session.paired ? Color("Grayed") : Color("Color3"))
                    .cornerRadius(10)
                    .disabled(!session.paired)
                }.padding()
            }
        }
    }

