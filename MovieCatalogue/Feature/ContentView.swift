//
//  ContentView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 15/9/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
