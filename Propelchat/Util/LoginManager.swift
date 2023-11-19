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
        guard let request = ApiUtil.createHttpRequest(endpoint: "loginUser", httpMethod: "POST", data: loginData)
        else {
            print("Could create request")
            return
        }
        
        // Send request and fetch data
        ApiUtil.fetchData(with: request) { (decodedData: LoginResponse?) in
            if let decodedData = decodedData {
                if(decodedData.status == "bad") {
                    errorText.wrappedValue = "Something went wrong, try another username"
                    return
                }
                
                DispatchQueue.main.async {
                    if let token = decodedData.token {
                        tokenManager.saveTokenAndUsername(token, username)
                    }
                }
                print("Log in was succesfull")
            } else {
                print("Could not decode data from api/login")
            }
        }
    }
    
    func sendRegisterRequest(username: String, password: String, errorText: Binding<String>, tokenManager: TokenManager) {
        // Create data codable
        let registerData = RegisterData(username: username, password: password)
        
        // Create request
        guard let request = ApiUtil.createHttpRequest(endpoint: "registerUser", httpMethod: "POST", data: registerData)
        else {
            print("Could not create register request")
            return
        }
        
        
        // Send request and fetch data
        ApiUtil.fetchData(with: request) { (decodedData: LoginResponse?) in
            if let decodedData = decodedData {
                if(decodedData.status == "bad") {
                    errorText.wrappedValue = "Something went wrong, try another username"
                    return
                }
                
                DispatchQueue.main.async {
                    if let token = decodedData.token {
                        tokenManager.saveTokenAndUsername(token, username)
                    }
                }
                print("Registration was succesful")
            } else {
                print("Could not decode data from api/register")
            }
        }
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
