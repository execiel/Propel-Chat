//
//  HomeView.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-13.
//

import Foundation
import SwiftUI


struct HomeView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Your conversations")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Colorscheme.bg_primary)
                        .padding()
                        .cornerRadius(0)
                    NavigationLink(destination: SearchView(), label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Colorscheme.bg_primary)
                    }).padding()
                    NavigationLink(destination: Text("Settings"), label: {
                        Image(systemName: "gear")
                            .foregroundColor(Colorscheme.bg_primary)
                    }).padding()
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Colorscheme.hl_secondary, Colorscheme.hl_primary]), startPoint: .leading, endPoint: .trailing)
                )
                
                Text("Convo 1")
                Text("Convo 1")
                Text("Convo 1")
                Text("Convo 1")
                Text("Convo 1")
                Text("Convo 1")
                Text("Convo 1")
                Text("Convo 1")
                
                Spacer()
                
            }
        }
    }
    
}
