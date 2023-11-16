//
//  TokenManager.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation

class TokenManager: ObservableObject {
    @Published var token: String?
    @Published var username: String?
    private let tokenKey = "authToken"
    private let usernameKey = "username"
    private let defaults = UserDefaults.standard
    
    func checkToken() -> Bool {
        guard let savedToken = defaults.string(forKey: tokenKey)
        else { return false }
        
        guard let savedUsername = defaults.string(forKey: usernameKey)
        else { return false }
        
        self.token = savedToken
        self.username = savedUsername
        print(self.username)
        
        return true
    }
    
    func saveTokenAndUsername(_ setToken: String, _ setUsername: String) {
        // Save the token to UserDefaults
        defaults.set(setToken, forKey: tokenKey)
        defaults.set(setUsername, forKey: usernameKey)
        
        // Update the token
        self.token = setToken
    }
}
