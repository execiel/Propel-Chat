//
//  PreviewView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-14.
//

import Foundation
import SwiftUI

struct PreviewView: View {
    let preview: ConversationPreview
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack{
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Colorscheme.hl_secondary)
                    .overlay(
                        Text(String(preview.user.uppercased().first!))
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                Text(preview.user)
                    .font(.headline)
                    .foregroundColor(Colorscheme.txt_primary)
                Spacer()
            }
            Text("Hejsan svejsan")
                .font(.subheadline)
                .foregroundColor(Colorscheme.txt_secondary)
        }
        .padding(15)
        .background(Colorscheme.bg_primary)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
