//
//  Extention.swift
//  Home
//
//  Created by Rasyid Ridla on 5/10/21.
//

import Foundation
import SwiftUI

// MARK: CustomShape
public struct CustomShape: Shape {
    var corner: UIRectCorner
    var radius: CGFloat
    
    public init(corner: UIRectCorner, radius: CGFloat) {
        self.corner = corner
        self.radius = radius
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

// MARK: RatingView
public struct RatingView: View {
    var ratingText: Double
    
    public init(rating: Double) {
        self.ratingText = rating
    }
    
    public var body: some View {
        Text("\(String(format: "%.1f",ratingText))")
            .foregroundColor(.black)
            .padding(5)
            .background(Color.yellow)
            .clipShape(CustomShape(corner: [.allCorners], radius: 5))
    }
}

// MARK: NextPageView
public struct NextPageView: View {
    
    public init(){}
    
    public var body: some View {
        VStack {
            Text("Next Page..").font(.caption)
            Image(systemName: "arrowtriangle.down.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
        }.padding(.vertical, 20)
    }
}
