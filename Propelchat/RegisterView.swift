//
//  RegisterView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-12.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack{
            Spacer()
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            TextField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            Button(action: {
                print("Button pressed with name \(username), password \(password)")
                sendRegisterRequest(username, password)
            }, label: {
                GradientButton(text: "Register")
            })
            
            Spacer()
        }
        .navigationTitle("Register").padding()
    }
}


func sendRegisterRequest(_ username: String, _ password: String) {
    guard let url = URL(string: "http://localhost:3000/api/registerUser") else {
        print("Invalid URL")
        return
    }

    // Create your model and encode it to JSON data
    let registerData = RegisterData(name: username, password: password)
    guard let jsonData = try? JSONEncoder().encode(registerData) else {
        print("Error encoding JSON data")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
        } else if let httpResponse = response as? HTTPURLResponse {
            DispatchQueue.main.async {
                print(httpResponse)
                print("Printed http response")
            }
        }
    }.resume()
}

struct RegisterData: Codable {
    let name: String
    let password: String
}
