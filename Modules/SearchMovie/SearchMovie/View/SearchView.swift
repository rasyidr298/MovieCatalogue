//
//  SearchView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import SwiftUI
import Common

public struct SearchView: View {
    
    @EnvironmentObject var searchVieModel: SearchViewModel
    @State var widthScreen = UIScreen.main.bounds.width
    @State var heightScreen = UIScreen.main.bounds.height
    
    public init(){}
    
    public var body: some View {
        VStack {
            SearchField()
            SearchResult()
        }
    }
}

public struct SearchResult: View {
    
    @EnvironmentObject var searchVieModel: SearchViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    public var body: some View {
        if !searchVieModel.searchMovies.isEmpty {
            
            let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridItems, content: {
                    ForEach(searchVieModel.searchMovies) {movies in
                        SearchCard(movie: movies).onTapGesture {
                            withAnimation { viewRouter.currentPage = .detailPageView(movie: movies)}
                        }
                    }
                })
                
                if searchVieModel.isShowNextPage() {
                    Button(action: {
                        searchVieModel.pageSearch += 1
                        searchVieModel.doSearchMovie()
                    }, label: {
                        if searchVieModel.isLastPage() {
                            Text("")
                        } else {
                            NextPageView()
                        }
                    })
                }
            }
            
        } else if searchVieModel.isResultEmpty() {
            Spacer()
            Text("Movie Not Found")
            Spacer()
        } else {
            Spacer()
            Text("Please Search Your Movie")
            Spacer()
        }
        
    }
}

struct SearchField: View {
    
    @EnvironmentObject var searchVieModel: SearchViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack {
            Button(action: {
                viewRouter.currentPage = .homePageView
            }, label: {
                Image(systemName: "arrow.left")
            })
            
            TextField("Search Movie", text: $searchVieModel.searchQueryText)
                .padding(.horizontal, 40)
                .frame(height: 45)
                .clipped()
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                        RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
                    }
                )
        }.padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
        
    }
    
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//            .environmentObject(SearchViewModel(searchUseCase: Injection().provideSearch()))
//            .environmentObject(ViewRouter())
//    }
//}
