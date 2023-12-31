//
//  HomeView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI


struct HomeView: View {
    @EnvironmentObject var conversationManager: ConversationManager
    @EnvironmentObject var tokenManager: TokenManager
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Your conversations")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Colorscheme.bg_primary)
                        .padding()
                        .cornerRadius(0)
                    NavigationLink(destination: SearchView(), label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Colorscheme.bg_primary)
                    }).padding()
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "gear")
                            .foregroundColor(Colorscheme.bg_primary)
                    }).padding()
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Colorscheme.hl_secondary, Colorscheme.hl_primary]), startPoint: .leading, endPoint: .trailing)
                )
                ScrollView {
                    VStack {
                        if(conversationManager.conversationPreviews != nil) {
                            ForEach(conversationManager.conversationPreviews!.reversed(), id: \.self) { preview in
                                NavigationLink(
                                    destination: ConversationView(preview: preview), label: {
                                    PreviewView(preview: preview).padding(.horizontal, 15).padding(.vertical, 5)
                                })
                            }
                        }
                        else {
                            Text("No conversations have been started")
                        }
                    }
                }
                Spacer()
            }
        }.onAppear {
            conversationManager.startFetchPreviewsTimer(token: tokenManager.token!)
        }.onDisappear {
            conversationManager.stopTimer()
        }
    }
    
}
