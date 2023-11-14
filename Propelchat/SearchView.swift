//
//  SearchView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            Button(action: {
                print("Button pressed with name \(username)")
            }, label: {
                GradientButton(text: "Add")
            })
            .padding()
            Spacer()
        }
        .navigationTitle("Add for a user")
    }
}
