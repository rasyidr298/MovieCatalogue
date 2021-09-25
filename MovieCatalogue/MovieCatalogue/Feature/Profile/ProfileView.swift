//
//  ProfileView.swift
//  MovieCatalogue
//
//  Created by Rasyid Ridla on 17/9/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                HStack {
                    Spacer()
                    Image("img_profile")
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                    Spacer()
                }.padding(.init(top: 0, leading: 0, bottom: 40, trailing: 0))
                
                Button(action: {
                    viewRouter.currentPage = .homePageView
                }, label: {
                    Image(systemName: "arrow.left")
                }).offset(x: 20, y: 0)
            })
            
            Form {
                Section(header:
                            Text("Biodata")
                            .font(.body)
                            .fontWeight(.bold)) {
                    Text("Rasyid Ridla")
                    Text("Rasyidridla298@gmail.com")
                    Text("Yogyakarta")
                    Text("linkedin.com/in/rasyidr298/")
                    Text("github.com/rasyidr298")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
