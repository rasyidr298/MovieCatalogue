//
//  CarouselViewNice.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 18/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

private class CarouselConfig: ObservableObject {
    @Published var cardWidth: CGFloat = 0
    @Published var cardCount: Int = 0
    @Published var selected: Int = 0
}

public struct Carousel<Cards: View>: View {
    let cards: Cards
    
    private var config: CarouselConfig
    
    @GestureState private var isDetectingLongPress = false
    
    @State private var offset: CGFloat = 0
    @State private var gestureOffset: CGFloat = 0
    
    private let spacing: CGFloat
    
    public init(
        cardWidth: CGFloat, selected: Int = 0, spacing: CGFloat = 20,
        @ViewBuilder cards: @escaping () -> Cards
    ) {
        self.config = CarouselConfig()
        self.config.cardWidth = cardWidth
        self.config.selected = selected
        
        self.spacing = spacing
        
        self.cards = cards()
    }
    
    func offset(for index: Int, geometry: GeometryProxy) -> CGFloat {
        return (geometry.size.width - self.config.cardWidth) / 2 - CGFloat(self.config.selected)
            * (self.config.cardWidth + spacing)
    }
    
    public var body: some View {
        GeometryReader {geometry in
            HStack(alignment: .center, spacing: self.spacing) {
                cards
                    .environmentObject(config)
            }
            .offset(x: offset + gestureOffset)
            .onAppear {
                self.offset = self.offset(for: self.config.selected, geometry: geometry)
            }
            .gesture(
                DragGesture().updating($isDetectingLongPress) { currentState, _ , _ in
                    DispatchQueue.main.async {
                        self.gestureOffset = currentState.translation.width
                    }
                    
                }.onEnded { value in
                    self.offset += self.gestureOffset
                    self.gestureOffset = 0
                    if value.translation.width < -(geometry.size.width / 6) {
                        self.config.selected = min(self.config.selected + 1, self.config.cardCount - 1)
                    } else if value.translation.width > (geometry.size.width / 6) {
                        self.config.selected = max(0, self.config.selected - 1)
                    }
                    withAnimation(.easeOut(duration: 0.3)) {
                        self.offset = self.offset(for: self.config.selected, geometry: geometry)
                    }
                })
        }
    }
}

public struct CarouselCardModif<Content: View>: View {
    @EnvironmentObject fileprivate var config: CarouselConfig
    
    let content: Content
    @State private var cardId: Int?
    
    var isActive: Bool {
        return cardId == config.cardCount - config.selected - 1
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .frame(width: config.cardWidth)
            .scaleEffect(isActive ? 1 : 0.9)
            .animation(.easeInOut, value: isActive)
            .zIndex(isActive ? 1 : 0)
            .onAppear {
                self.cardId = self.config.cardCount
                self.config.cardCount += 1
            }
    }
}
