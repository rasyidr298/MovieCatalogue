//
//  ViewRouter.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 19/9/21.
//

import SwiftUI
import Movie

public class ViewRouter: ObservableObject {
    
    public init(){}
    
    public enum Page {
        case homePageView
        case detailPageView(movie: MovieModel)
        case searchPageView
        case favoritePageView
        case profilePageView
    }
    
    @Published public var currentPage: Page = .homePageView
}
