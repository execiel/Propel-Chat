//
//  LoginManager.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI

class LoginManager {
    
    func sendLoginRequest(username: String, password: String, errorText: Binding<String>, tokenManager: TokenManager) {
        // Create data codable
        let loginData = RegisterData(username: username, password: password)
        
        // Create request
        let request = ApiUtil.createHttpRequest(address: "http://localhost:3000/api/loginUser", httpMethod: "POST", data: loginData)
        
        URLSession.shared.dataTask(with: request!) { (data, response, error) in
            if let decodedData = try? JSONDecoder().decode(LoginResponse.self, from: data!) {
                print(decodedData)
                
                if(decodedData.status == "bad") {
                    errorText.wrappedValue = "Something went wrong, try another username"
                    return
                }
                
                DispatchQueue.main.async {
                    if let token = decodedData.token {
                        tokenManager.saveToken(token)
                        print("Saved token")
                    }
                }
                print("Registration was succesful")
                
                // TODO save token to token manager
            } else {
                print("Something went wrong with decoding the response")
            }
        }.resume()
    }
    
    func sendRegisterRequest(username: String, password: String, errorText: Binding<String>, tokenManager: TokenManager) {
        // Create data codable
        let registerData = RegisterData(username: username, password: password)
        
        // Create request
        let request = ApiUtil.createHttpRequest(address: "http://nlocalhost:3000/api/registerUser", httpMethod: "POST", data: registerData)
        
        URLSession.shared.dataTask(with: request!) { (data, response, error) in
            if let decodedData = try? JSONDecoder().decode(LoginResponse.self, from: data!) {
                print(decodedData)
                if(decodedData.status == "bad") {
                    errorText.wrappedValue = "Something went wrong, try another username"
                    return
                }
                
                DispatchQueue.main.async {
                    if let token = decodedData.token {
                        tokenManager.saveToken(token)
                        print("Saved token")
                    }
                }
                print("Registration was succesful")
                
                // TODO save token to token manager
            } else {
                print("Something went wrong with decoding the response")
            }
        }.resume()
    }
    
    
    private struct RegisterData: Codable {
        let username: String
        let password: String
    }
    
    private struct LoginResponse: Codable {
        let status: String
        let token: String?
    }
    
}
