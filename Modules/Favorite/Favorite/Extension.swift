//
//  Extension.swift
//  Favorite
//
//  Created by Rasyid Ridla on 5/10/21.
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
