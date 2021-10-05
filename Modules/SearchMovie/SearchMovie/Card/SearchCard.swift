//
//  SearchCard.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 18/9/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Movie

struct SearchCard: View {
    let movie: MovieModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            WebImage(url: URL(string: movie.backdrop ))
                .resizable()
                .indicator(.activity)
                .cornerRadius(10)
                .frame(width: UIScreen.main.bounds.width / 2.1, height: (UIScreen.main.bounds.width / 1.8) / 2)
            
            Text(movie.title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .lineLimit(1)
                .padding(10)
        }
    }
}
