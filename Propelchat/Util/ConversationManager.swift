//
//  ConversationManager.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-14.
//

import Foundation
import SwiftUI

class ConversationManager: ObservableObject {
    @Published var conversationPreviews: [ConversationPreview]?
    @Published var currentMessages: [Message]?
    private var timer: Timer?
    
    func addMessage(token: String, conversationId: String, messageContent: String) {
        let data = AddMessageData(token: token, conversationId: conversationId, messageContent: messageContent)
        
        // Create request
        guard let request = ApiUtil.createHttpRequest(endpoint: "addMessage", httpMethod: "PUT", data: data)
        else {
            print("could not create request")
            return
        }
        
        // Fetch data
        ApiUtil.fetchData(with: request) { (decodedData: MessagesResponse?) in
            if let decodedData = decodedData {
                if(decodedData.status == "bad") {
                    print("got status: 'bad', from addMessage")
                    return
                }
                
                DispatchQueue.main.async {
                    self.currentMessages = decodedData.messages
                }
            } else {
                print("Could not decode fetched data")
            }
        }
    }
    
    func fetchMessages(token: String, conversationId: String) {
        let data = MessagesData(token: token, conversationId: conversationId)
        
        // Create request
        guard let request = ApiUtil.createHttpRequest(endpoint: "getMessages", httpMethod: "POST", data: data)
        else {
            print("could not create request")
            return
        }
        
        // Fetch data
        ApiUtil.fetchData(with: request) { (decodedData: MessagesResponse?) in
            if let decodedData = decodedData {
                if(decodedData.status == "bad") {
                    print("got status: 'bad', from getMessages")
                    print(decodedData)
                    
                    DispatchQueue.main.async {
                        self.currentMessages = nil
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    self.currentMessages = decodedData.messages
                }
            } else {
                print("Could not decode fetched data")
            }
        }
    }
    
    func fetchPreviews(token: String) {
        let data = TokenData(token: token)
        
        // Create request
        guard let request = ApiUtil.createHttpRequest(endpoint: "getHome", httpMethod: "POST", data: data)
        else {
            print("could not create request")
            return
        }
        
        // Send request
        ApiUtil.fetchData(with: request) { (decodedData: ConversationPreviewResponse?) in
            if let decodedData = decodedData {
                if(decodedData.status == "bad") {
                    print("Could not get previews")
                    return
                }
                
                // Set new list of active conversation previews
                if let conPrevs = decodedData.conversationPreviews {
                    DispatchQueue.main.async {
                        self.conversationPreviews = conPrevs
                    }
                }
            } else {
                print("Could not decode fetched data")
            }
        }
    }
    
    // Sends request to create conversation
    func createConversation(username: String, token: String, message: Binding<String>) {
        // Create data
        let data = FindUserData(token: token, username: username)
        
        // Create request
        guard let request = ApiUtil.createHttpRequest(endpoint: "findUser", httpMethod: "POST", data: data)
        else {
            print("Could not create request")
            return
        }
        
        // Send request
        ApiUtil.fetchData(with: request) { (decodedData: ConversationPreviewResponse?) in
            if let decodedData = decodedData {
                if(decodedData.status == "bad") {
                    message.wrappedValue = "Could not find any user by that name"
                    return
                }
                
                // Set new list of active conversation previews
                if let conPrevs = decodedData.conversationPreviews {
                    DispatchQueue.main.async {
                        self.conversationPreviews = conPrevs
                    }
                }
                
                // Tell the user that conversation has been added
                message.wrappedValue = "User has been added"
            } else {
                print("Could not decode fetched data")
            }
        }
    }
    
    // Timer functions
    func startFetchMessagesTimer(token: String, conversationId: String) {
        // Fetch initially
        self.fetchMessages(token: token, conversationId: conversationId)
        
        // Continue fetching every one seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.fetchMessages(token: token, conversationId: conversationId)
        }
    }
    
    func startFetchPreviewsTimer(token: String) {
        // Fetch initially
        self.fetchPreviews(token: token)
        
        // Continue fetching every one seconds
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.fetchPreviews(token: token)
        }
    }
    
    func stopTimer() {
        // Invalidate the timer when it's no longer needed
        timer?.invalidate()
        timer = nil
    }
    
    // Structs
    struct AddMessageData: Codable {
        let token: String
        let conversationId: String
        let messageContent: String
    }
    
    struct MessagesData: Codable {
        let token: String
        let conversationId: String
    }
    
    struct MessagesResponse: Codable {
        let status: String
        let messages: [Message]?
    }
    
    struct FindUserData: Codable {
        let token: String
        let username: String
    }
    
    struct ConversationPreviewResponse: Codable {
        let status: String
        let conversationPreviews: [ConversationPreview]?
    }
}

struct StatusResponse: Codable {
    let status: String
}

struct ConversationPreview: Codable, Hashable {
    let user: String
    let id: String
}

struct Message: Codable, Hashable {
    let user: String
    let content: String
}

struct TokenData: Codable {
    let token: String
}
