//
//  ApiUtil.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-14.
//

import Foundation

class ApiUtil {
    static func createHttpRequest(address: String, httpMethod: String, data: Codable) -> URLRequest? {
        // Connect to url
        guard let url = URL(string: address) else {
            print("Invalid URL")
            return nil
        }
        
        // Create json data
        let registerData = data
        guard let jsonData = try? JSONEncoder().encode(registerData) else {
            print("Error encoding JSON data")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        return request
    }
}
