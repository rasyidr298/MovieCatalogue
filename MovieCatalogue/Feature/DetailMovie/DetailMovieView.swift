//
//  Detail.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMovieView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var detailViewModel: DetailMovieViewModel
    @State private var showConfirmation = false
    @State var widthScreen = UIScreen.main.bounds.width
    @State var heightScreen = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                
                // MARK: Top Detail
                ZStack(alignment: .topTrailing) {
                    ZStack(alignment: .topLeading) {
                        ZStack(alignment: .bottomTrailing) {
                            WebImage(url: URL(string: detailViewModel.detailMovie.backdrop))
                                .resizable()
                                .indicator(.activity)
                                .frame(width: widthScreen, height: widthScreen / 1.3)
                                .aspectRatio(contentMode: .fit)
                            RatingView(ratingText: 7.8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                        }
                        Button(action: {
                            viewRouter.currentPage = .homePageView
                        }, label: {
                            Image(systemName: "arrow.left")
                        }).padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 0))
                    }
                    Button(action: {
                        if detailViewModel.isFavorite {
                          self.showConfirmation = true
                        } else {
                            detailViewModel.addMovieToFavorite()
                        }
                    }, label: {
                      Image(systemName: detailViewModel.isFavorite ? "heart.fill" : "heart").accentColor(.red)
                    }).padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 20))
                }
                
                // MARK: Body Detail
                VStack(alignment: .leading) {
                    Text("Release Date : \(detailViewModel.detailMovie.releaseDate)").font(.footnote).fontWeight(.light)
                    Text(detailViewModel.detailMovie.title).font(.title3).fontWeight(.semibold)
                    Text(detailViewModel.detailMovie.genre).font(.footnote).fontWeight(.regular)
                    Text("Production Companies : ").font(.footnote).fontWeight(.semibold).padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(detailViewModel.detailMovie.productionCompanies) {companies in
                                Text(companies.name).font(.footnote).padding(5).background(Color.secondary).foregroundColor(.white).clipShape(CustomShape(corner: [.allCorners], radius: 5))
                            }
                        }
                    }
                    Text("Description :").font(.footnote).fontWeight(.semibold).padding(.top, 5)
                    Text(detailViewModel.detailMovie.overview).font(.body).fontWeight(.light).lineLimit(20)
                    Text("Cast : ").font(.footnote).fontWeight(.semibold).padding(.top, 5)
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(detailViewModel.detailMovie.casts) {cast in
                                    VStack {
                                        WebImage(url: URL(string: cast.profile)).resizable()
                                            .placeholder {
                                              Image("img_broken")
                                                .resizable()
                                                .frame(width: 70, height: 70, alignment: .center)
                                            }
                                            .indicator(.activity).cornerRadius(10).frame(width: 70, height: 100)
                                        Text(cast.name).font(.footnote).fontWeight(.medium).lineLimit(2)
                                    }.frame(width: 70, height: 150)
                                }
                            }
                        }
                    }
                }.padding(10)
                
            }
            .frame(alignment: .top).edgesIgnoringSafeArea(.all)
            .onAppear {
                detailViewModel.getDetailMovie()
                detailViewModel.checkIsFavorite()
            }
            .alert(isPresented: $showConfirmation) {
              Alert(
                title: Text("Are you sure want to delete \(detailViewModel.movie.title) from favorite?"),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton:
                  .destructive(
                    Text("Delete"),
                    action: {
                        detailViewModel.deleteFavorite()
                    }
                )
              )
            }
        }
    }
}

struct DetailMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieView(detailViewModel: DetailMovieViewModel(detailUseCase: Injection().provideDetail(movie: .default)))
    }
}
