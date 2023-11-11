//
//  SplashScreenView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-11.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        LinearGradient(gradient:
                       Gradient(colors: [Colorscheme.hl_secondary, Colorscheme.hl_primary]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Image("splash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            )
    }
}
