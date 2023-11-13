//
//  PropelchatApp.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-11.
//

import SwiftUI

@main
struct PropelchatApp: App {
    
    @State private var showSplashScreen = true
    
    var body: some Scene {
        
        WindowGroup {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        // Add any setup code or delays here if needed
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                ContentView().environmentObject(TokenManager())
            }
        }
    }
}
