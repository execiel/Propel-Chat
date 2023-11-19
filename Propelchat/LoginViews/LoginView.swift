//
//  LoginView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI

struct LoginView: View {
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
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            Text(error)
                .foregroundColor(Colorscheme.hl_error)
                .font(.footnote)
            Button(action: {
                print("Button pressed with name \(username), password \(password)")
                loginManager.sendLoginRequest(
                    username: username,
                    password: password,
                    errorText: $error,
                    tokenManager: tokenManager
                )
            }, label: {
                GradientButton(text: "Log in")
            })
            
            Spacer()
        }
        .navigationTitle("Log in").padding()
    }
}


