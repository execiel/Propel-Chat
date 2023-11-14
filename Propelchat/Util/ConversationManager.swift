//
//  ConversationManager.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-14.
//

import Foundation
class ConversationManager: ObservableObject {
    @Published var conversationPreviews: [ConversationPreview]?
    // @Published var currentConversation: Conversation
    
    // Sends request to create conversation
    func createConversation(username: String, token: String) {
        
    }
    
    struct findUserData: Codable {
        let token: String
        let username: String
    }
    
    struct tempResponse
}

struct ConversationPreview {
    let user: String
    let id: String
}

