//
//  ContentView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-11.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var tokenManager: TokenManager
    
    var body: some View {
        if(tokenManager.loggedIn) {
            HomeView().environmentObject(ConversationManager())
        } else {
            GreetingView()
                .onAppear {
                    tokenManager.checkLoggedIn()
                    print(tokenManager.loggedIn)
                }
        }
    }
}
