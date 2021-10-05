//
//  File.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 18/9/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Movie
import Common

struct FavoriteCard: View {
    let movie: MovieModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            HStack(alignment: .top) {
                WebImage(url: URL(string: movie.poster))
                    .resizable()
                    .indicator(.activity)
                    .cornerRadius(18)
                    .frame(width: 90, height: 130)
                    .offset(x: 0, y: -30)
                    .padding(.leading, 16)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(movie.title)
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .lineLimit(2)
                    
                    Text(movie.releaseDateFormatted)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(movie.overview)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    Spacer()
                }
                .padding(.top, 16)
                
                Spacer()
                
                RatingView(rating: movie.voteAverage)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .frame(height: 130)
        .padding(.top, 40)
    }
}
