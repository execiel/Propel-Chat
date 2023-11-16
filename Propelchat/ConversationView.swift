//
//  ConversationView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var conversationManager: ConversationManager
    @EnvironmentObject var tokenManager: TokenManager
    
    var body: some View {
        ScrollView {
            VStack{
                if let messages = conversationManager.currentMessages {
                    ForEach(messages, id: \.self) { message in
                        MessageBubble(message: message.content, fromUser: (tokenManager.username == message.user))
                    }
                } else {
                    Text("No messages could be found")
                }
                HStack {
                    TextField("Type a message", text: $viewModel.newMessageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button("Send") {
                        print()
                    }
                    .padding(.trailing)
                }
                .padding(.bottom)
            }
        }
    }
}
