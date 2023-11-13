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
    @State private var error: String = ""
    @EnvironmentObject var tokenManager: TokenManager;
    
    let loginManager = LoginManager()
    
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
            Text(error)
                .foregroundColor(Colorscheme.hl_error)
                .font(.footnote)
            Button(action: {
                print("Button pressed with name \(username), password \(password)")
                loginManager.sendRegisterRequest(
                    username: username,
                    password: password,
                    errorText: $error,
                    tokenManager: tokenManager
                )
            }, label: {
                GradientButton(text: "Register")
            })
            
            Spacer()
        }
        .navigationTitle("Register").padding()
    }
}


