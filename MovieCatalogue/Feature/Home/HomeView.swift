//
//  HomeView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        
        ScrollView(.vertical) {
            ForEach(homeViewModel.movies) {movies in
                Text(movies.title).padding()
            }
            .onAppear {
                homeViewModel.getPopularMovie(page: 3)
            }
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
