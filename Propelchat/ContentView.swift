//
//  ContentView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-11.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var tokenManager: TokenManager
    @State private var loggenIn = false
    
    var body: some View {
        if(loggenIn) {
            HomeView().environmentObject(ConversationManager())
        } else {
            GreetingView()
                .onChange(of: tokenManager.token) { token in
                    if(token == nil) { return }
                    loggenIn = true
                    print("Token exists")
                }
                .onAppear {
                    // Set logged in to true and give tokenmanager its token if its in defaults
                    // loggenIn = tokenManager.checkToken()
                }
        }
    }
}
