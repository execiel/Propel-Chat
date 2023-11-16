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
    
    func getMessages(token: String, conversationId: String) {
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
    
    func getPreviews(token: String) {
        let data = TokenData(token: token)
        
        // Create request
        let request = ApiUtil.createHttpRequest(endpoint: "getHome", httpMethod: "POST", data: data)
        
        // Send request
        URLSession.shared.dataTask(with: request!) { (data, response, error) in
            if let decodedData = try? JSONDecoder().decode(ConversationPreviewResponse.self, from: data!) {
                // Send error message if user doesnt exist
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
                print("Something went wrong with decoding the response")
            }
        }.resume()
    }
    
    // Sends request to create conversation
    func createConversation(username: String, token: String, message: Binding<String>) {
        // Create data
        let data = FindUserData(token: token, username: username)
        
        // Create request
        let request = ApiUtil.createHttpRequest(endpoint: "findUser", httpMethod: "POST", data: data)
        
        // Send request
        URLSession.shared.dataTask(with: request!) { (data, response, error) in
            if let decodedData = try? JSONDecoder().decode(ConversationPreviewResponse.self, from: data!) {
                // Send error message if user doesnt exist
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
                print("Something went wrong with decoding the response")
            }
        }.resume()
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
