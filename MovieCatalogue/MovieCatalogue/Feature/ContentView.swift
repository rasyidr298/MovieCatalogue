//
//  ContentView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 15/9/21.
//

import SwiftUI
import Movie
import Common
import Home
import Detail
import SearchMovie
import Favorite
import Profile

struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        switch viewRouter.currentPage {
        case .homePageView:
            HomeView()
        case .detailPageView(let movie):
            DetailMovieView(viewModel: DetailMovieViewModel(detailUseCase: Injection().provideDetail(movie: movie)))
        case .searchPageView:
            SearchView()
        case .favoritePageView:
            FavoriteView()
        case .profilePageView:
            ProfileView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
