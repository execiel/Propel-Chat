//
//  TokenManager.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation

class TokenManager: ObservableObject {
    @Published var token: String?
    private let tokenKey = "authToken"
    private let defaults = UserDefaults.standard
    
    func checkToken() -> Bool {
        if let savedToken = defaults.string(forKey: tokenKey) {
            self.token = savedToken
            return true
        } else {
            return false
        }
    }
    
    func saveToken(_ setToken: String) {
        // Save the token to UserDefaults
        defaults.set(setToken, forKey: tokenKey)
        
        // Update the token
        self.token = setToken
    }
}
