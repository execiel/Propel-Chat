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
    @State private var messageText: String = ""
    
    let preview: ConversationPreview
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    if let messages = conversationManager.currentMessages {
                        ForEach(messages, id: \.self) { message in
                            MessageBubble(message: message.content, fromUser: (tokenManager.username == message.user))
                                .padding(5)
                        }
                    } else {
                        Text("No messages could be found")
                    }
                }
            }
            Spacer()
            HStack {
                TextField("Type a message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    print(messageText)
                    conversationManager.addMessage(
                        token: tokenManager.token!,
                        conversationId: preview.id,
                        messageContent: messageText
                    )
                    conversationManager.fetchMessages(token: tokenManager.token!, conversationId: preview.id)
                    messageText = ""
                }, label: {
                    Image("send")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }).padding(.trailing)
            }
            .padding(.bottom)
        }
        .navigationTitle(preview.user)
        .onAppear{
            conversationManager.startFetchMessagesTimer(token: tokenManager.token!, conversationId: preview.id)
        }
        .onDisappear{
            conversationManager.stopTimer()
        }
    }
}
