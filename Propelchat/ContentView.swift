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
            HomeView()
        } else {
            GreetingView()
                .onChange(of: tokenManager.token) { token in
                    if(token == nil) { return }
                    loggenIn = true
                    print("Token exists")
                }
        }
   }
}
