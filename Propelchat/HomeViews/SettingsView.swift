//
//  Settings.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-19.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var tokenManager: TokenManager
    
    var body: some View {
        VStack {
            Button(action: {
                tokenManager.logOut()
            }, label: { GradientButton(text: "Log out").padding() } )
        }
        .navigationTitle("\(tokenManager.username!)'s Settings")
    }
}
