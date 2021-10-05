//
//  HomeCard.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 18/9/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Movie
import Common

struct HomeCard: View {
    var item: MovieModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                WebImage(url: URL(string: item.poster ))
                    .resizable()
                    .indicator(.activity)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width / 3.3, height: (UIScreen.main.bounds.width / 3.3) * 1.4)
                
                RatingView(rating: item.voteAverage)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
            }
            
            Text(item.title)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(2)
                .padding(.horizontal, 5)
                .multilineTextAlignment(.leading)
                .frame(width: 100)
            
            Spacer()
        }
    }
}
