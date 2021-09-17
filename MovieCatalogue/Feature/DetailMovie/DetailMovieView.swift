//
//  Detail.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import SwiftUI

struct DetailMovieView: View {
    
    @ObservedObject var viewModel: DetailMovieViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct DetailMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieView(viewModel: DetailMovieViewModel(detailUseCase: Injection().provideDetail(movie: .default)))
    }
}
