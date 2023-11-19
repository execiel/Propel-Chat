//
//  GreetingView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-12.
//

import Foundation
import SwiftUI

struct GreetingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("propel-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 100)
                Text("Blazing fast messaging app")
                Spacer()
                NavigationLink(destination: LoginView(), label: { GradientButton(text: "Login") }).padding()
                NavigationLink(destination: RegisterView(), label: { GradientButton(text: "Register") }).padding()
            }
        }
    }
}
