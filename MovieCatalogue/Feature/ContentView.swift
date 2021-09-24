//
//  ContentView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 15/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        switch viewRouter.currentPage {
        case .homePageView:
            HomeView()
        case .detailPageView(let movie):
            DetailMovieView(detailViewModel: DetailMovieViewModel(detailUseCase: Injection().provideDetail(movie: movie)))
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
