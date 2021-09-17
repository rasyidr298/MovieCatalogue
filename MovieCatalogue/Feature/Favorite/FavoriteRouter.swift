//
//  FavoriteMovieRouter.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import SwiftUI

class FavoriteRouter {
    
    // MARK: makeDetailView
    func makeDetailView(for movie: MovieModel) -> some View {
        let detailMovieUseCase = Injection.init().provideDetail(movie: movie)
        let viewModel = DetailMovieViewModel(detailUseCase: detailMovieUseCase)
        return DetailMovieView(viewModel: viewModel)
    }
}
