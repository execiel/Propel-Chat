//
//  GradientButton.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-12.
//

import Foundation
import SwiftUI

// Needs to be wrapped in a navigation link
struct GradientButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundColor(Colorscheme.bg_primary)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Colorscheme.hl_secondary, Colorscheme.hl_primary]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(30)
    }
}
