//
//  ViewRouter.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 19/9/21.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    enum Page {
        case homePageView
        case detailPageView(movie: MovieModel)
        case searchPageView
        case favoritePageView
        case profilePageView
    }
    
    @Published var currentPage: Page = .homePageView
}
