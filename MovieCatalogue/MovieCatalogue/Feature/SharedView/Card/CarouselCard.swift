//
//  SearchCard.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 18/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarouselCard: View {
    var item: MovieModel
    @State var heightMainView = UIScreen.main.bounds.height
    @State var widthMainView = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            WebImage(url: URL(string: item.backdrop))
                .resizable()
                .indicator(.activity)
                .frame(width: widthMainView - 35, height: (widthMainView - 35) / 1.4)
                .aspectRatio(contentMode: .fill)
            
            Text(item.title)
                .font(.callout)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
            
        }
        .clipShape(CustomShape(corner: [.allCorners], radius: 20))
    }
}
