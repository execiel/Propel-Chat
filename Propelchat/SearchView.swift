//
//  SearchView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    // TODO: Change this later
    @State private var message: String = ""
    @EnvironmentObject var tokenManager: TokenManager
    @EnvironmentObject var conversationManager: ConversationManager
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            Text(message).font(.caption).foregroundColor(Colorscheme.txt_secondary)
            Button(action: {
                conversationManager
                    .createConversation(
                        username: username,
                        token: tokenManager.token!,
                        message: $message)
                print("Button pressed with name \(username)")
            }, label: {
                GradientButton(text: "Add")
            })
            .padding()
            Spacer()
        }
        .navigationTitle("Add for a user")
    }
}
