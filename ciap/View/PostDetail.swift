//
//  PostDetail.swift
//  ciap
//
//  Created by una ivan on 07/07/23.
//

import SwiftUI

struct PostDetail: View {
    let post: Post
    let person: Person?
    @ObservedObject var dataViewModel = DataViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                NavigationLink(destination: UserSpeech(person: dataViewModel.person(for: post)!)) {
                    VStack(alignment: .leading){
                        HStack{
                            URLImage(urlString: dataViewModel.person(for: post)?.photouser ?? "")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .cornerRadius(52)
                            
                            Text(dataViewModel.person(for: post)?.name ?? "")
                                .font(.system(size: 16))
                                .bold()
                        }
                        HStack(){
                            ///untukk set width
                        }.frame(width: UIScreen.main.bounds.width - 40)
                    }.frame(width: UIScreen.main.bounds.width)
                }
                
                HStack{
                    Text(post.ciap)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                }.padding(EdgeInsets(top: 9, leading: 15, bottom: 0, trailing: 15))
                HStack(spacing: 24){
                    HStack(spacing: 2){
                        Image(systemName: "heart")
                        Text("\(post.likes)")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 2){
                        Image(systemName: "arrow.2.squarepath")
                        Text("\(post.respeech)")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 2){
                        Image(systemName: "message")
                        Text("\(post.responseCount)")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }.frame(maxWidth: .infinity, alignment: .leading)
//                    HStack(spacing: 2){
//                        Image(systemName: "paperplane")
//                    }
                }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                
                
                Divider()
                
                
                if let responses = post.responses {
                    Text("Responses:")
                        .font(.headline)
                        .padding(.top, 10)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    
                    ForEach(responses, id: \.id) { response in
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                URLImage(urlString: response.resthumbhs ?? "")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(25)
                                
                                VStack(alignment: .leading) {
                                    HStack{
                                        Text(response.resname)
                                            .font(.subheadline)
                                        Text("\(response.resdate)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Text(response.resciap)
                                        .font(.subheadline)
                                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                                    
                                    HStack(spacing: 24){
                                        HStack(spacing: 2){
                                            Image(systemName: "heart")
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                        HStack(spacing: 2){
                                            Image(systemName: "arrow.2.squarepath")
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                        HStack(spacing: 2){
                                            Image(systemName: "message")
                                        }.frame(maxWidth: .infinity, alignment: .leading)
//                                        HStack(spacing: 2){
//                                            Image(systemName: "paperplane")
//                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                        HStack(spacing: 2){
                                            Image(systemName: "square.and.arrow.up")
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                    }.padding(EdgeInsets(top: 5, leading: 15, bottom: 10, trailing: 15))
                                }
                            }
                            Divider()
                        }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        .padding(.vertical, 5)
                    }
                }
                Spacer()
            }.toolbar(.hidden, for: .bottomBar)
                .padding()
        }
    }
}
