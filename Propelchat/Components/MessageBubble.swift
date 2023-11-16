//
//  ConversationBubble.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-14.
//

import Foundation
import SwiftUI

struct MessageBubble: View {
    let message: String
    // let time: String
    let fromUser: Bool
    
    var body: some View {
        HStack {
            if(fromUser) {
                Spacer()
                VStack {
                    Text(message)
                        .font(.headline)
                        .foregroundColor(Colorscheme.bg_primary)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Colorscheme.hl_secondary, Colorscheme.hl_primary]), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(30)
                }
            } else {
                VStack {
                    Text(message)
                        .font(.headline)
                        .foregroundColor(Colorscheme.txt_primary)
                        .padding()
                        .background(Colorscheme.bg_secondary)
                        .cornerRadius(30)
                }
                Spacer()
            }
        }
    }
}
