//
//  HomeView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 16/9/21.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        TabView {
            ContentHomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
        }
    }
}

struct ContentHomeView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var homeViewModel : HomeViewModel
    @State var heightMainView = UIScreen.main.bounds.height
    @State var widthMainView = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                
                ZStack(alignment: .topTrailing) {
                    
                    // MARK: Carousel
                    Carousel(cardWidth: widthMainView - 60, spacing: 15) {
                        
                        ForEach(homeViewModel.nowPlayingMovies) {movies in
                            CarouselCardModif {
                                CarouselCard(item: movies).onTapGesture {
                                    withAnimation { viewRouter.currentPage = .detailPageView(movie: movies)}
                                }
                            }
                        }
                    }
                    .frame(height: (widthMainView - 35) / 1.4)
                    
                    HStack {
                        // MARK: Search Button
                        Button(action: { withAnimation {viewRouter.currentPage = .searchPageView}
                        }, label: {
                            Image(systemName: "magnifyingglass.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.white)
                        })
                        
                        // MARK: Profile Button
                        Button(action: { withAnimation {viewRouter.currentPage = .profilePageView}
                        }, label: {
                            Image("img_profile")
                                .resizable()
                                .frame(width: 30, height: 30)
                        })
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 30))
                }
                
                // MARK: ScrollView Horizontal
                Text("Popular Movies:").padding(.horizontal, 10).font(.body).padding(.top, 15)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        ForEach(homeViewModel.popularMovies) {movies in
                            HomeCard(item: movies).onTapGesture {
                                withAnimation { viewRouter.currentPage = .detailPageView(movie: movies)}
                            }
                        }
                    }.padding(.leading, 10)
                }
                .frame(width: widthMainView, height: (UIScreen.main.bounds.width / 3) * 1.6)
                
                // MARK: ScrollView Vertical
                Text("Top Rated Movies:").padding(.horizontal, 10).font(.body)
                let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridItems, content: {
                        
                        ForEach(homeViewModel.topRatedMovies) { movies in
                            HomeCard(item: movies).onTapGesture {
                                withAnimation { viewRouter.currentPage = .detailPageView(movie: movies)}
                            }
                        }
                    }).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                
            }.edgesIgnoringSafeArea(.all)
            
            // MARK: Next Page Button
            Button {
                homeViewModel.pageTopRated += 1
                homeViewModel.getTopRatedMovie(page: homeViewModel.pageTopRated)
            } label: {
                if homeViewModel.isLastPage() {
                    Text("")
                } else {
                    NextPageView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentHomeView()
            .environmentObject(HomeViewModel(homeUseCase: Injection().provideHome()))
            .environmentObject(ViewRouter())
    }
    
}
