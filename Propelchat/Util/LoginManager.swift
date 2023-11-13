//
//  LoginManager.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI

class LoginManager {
    
    func sendRegisterRequest(username: String, password: String, errorText: Binding<String>, tokenManager: TokenManager) {
        // Connect to url
        guard let url = URL(string: "http://localhost:3000/api/registerUser") else {
            print("Invalid URL")
            return
        }
        
        // Create json data
        let registerData = RegisterData(username: username, password: password)
        guard let jsonData = try? JSONEncoder().encode(registerData) else {
            print("Error encoding JSON data")
            return
        }
        
        // Create request
        let request = createHttpRequest(url: url, httpMethod: "POST", jsonData: jsonData)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
    
    func createHttpRequest(url: URL, httpMethod: String, jsonData: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        return request
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
