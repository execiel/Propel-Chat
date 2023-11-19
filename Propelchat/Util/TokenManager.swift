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
    @Published var loggedIn = false
    private let tokenKey = "authToken"
    private let usernameKey = "username"
    private let defaults = UserDefaults.standard
    
    func checkLoggedIn() {
        guard let savedToken = defaults.string(forKey: tokenKey)
        else {
            print("Found no token")
            self.loggedIn = false
            return
        }
        print(savedToken)
        
        guard let savedUsername = defaults.string(forKey: usernameKey)
        else {
            print("Found no username")
            self.loggedIn = false
            return
        }
        print(savedUsername)
        
        self.token = savedToken
        self.username = savedUsername
        self.loggedIn = true
    }
    
    func logOut() {
        defaults.set(nil, forKey: tokenKey)
        defaults.set(nil, forKey: usernameKey)
        self.loggedIn = false
    }
    
    func saveTokenAndUsername(_ setToken: String, _ setUsername: String) {
        // Save the token to UserDefaults
        defaults.set(setToken, forKey: tokenKey)
        defaults.set(setUsername, forKey: usernameKey)
        
        // Update the token
        self.token = setToken
        self.username = setUsername
        self.loggedIn = true
        
        // Save token
        print("Saved token")
    }
}
