//
//  CustomView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 18/9/21.
//

import Foundation
import SwiftUI

// MARK: CustomShape
struct CustomShape: Shape {
    var corner: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

// MARK: RatingView
struct RatingView: View {
    var ratingText: Double
    
    var body: some View {
        Text("\(String(format: "%.1f",ratingText))")
            .foregroundColor(.black)
            .padding(5)
            .background(Color.yellow)
            .clipShape(CustomShape(corner: [.allCorners], radius: 5))
    }
}

// MARK: NextPageView
struct NextPageView: View {
    var body: some View {
        VStack {
            Text("Next Page..").font(.caption)
            Image(systemName: "arrowtriangle.down.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
        }.padding(.vertical, 20)
    }
}
