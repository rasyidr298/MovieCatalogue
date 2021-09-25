//
//  FavoriteView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var favoriteVieModel: FavoriteViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ForEach(favoriteVieModel.favoriteMovies) {movies in
                FavoriteCard(movie: movies).onTapGesture {
                    withAnimation { viewRouter.currentPage = .detailPageView(movie: movies)}
                }
            }
            
        }.onAppear {
            favoriteVieModel.getFavoriteMovies()
            print(favoriteVieModel.favoriteMovies)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
