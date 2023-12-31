//
//  UserSpeech.swift
//  ciap
//
//  Created by unaivan on 13/07/23.
//

import SwiftUI

struct UserSpeech: View {
    let person: Person
    @ObservedObject var dataViewModel = DataViewModel()
    
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if number >= 1000000 {
            let millionNumber = Double(number) / 1000000.0
            return "\(formatter.string(from: NSNumber(value: millionNumber)) ?? "")M"
        } else if number >= 1000 {
            let thousandNumber = Double(number) / 1000.0
            return "\(formatter.string(from: NSNumber(value: thousandNumber)) ?? "")K"
        } else {
            return "\(number)"
        }
    }
    
    var body: some View {
//        ScrollView{
            VStack(alignment: .center, spacing: 8){
                
                HStack(alignment: .center){
                    HStack{
                        URLImage(urlString: person.photouser)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 72, height: 72)
                            .cornerRadius(52)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack{
                        Text(formatNumber(person.followers))
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                        Text("Followers")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack{
                        Text(formatNumber(person.following))
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                        Text("Following")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                }.frame(width: UIScreen.main.bounds.width - 40)
                
                HStack{
                    Text(person.name)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .bold()
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading){
                    Text(person.bio)
                        .foregroundColor(.secondary)
                        .font(.system(size: 16))
                }
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Button {
                } label: {
                    Text("Follow")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding(.bottom, 6)
                        .padding(.top, 6)
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(25)
                .padding(.bottom, 24)
                
            }
            .padding(.trailing, 18)
            .padding(.leading, 18)
            .padding(.top, 24)
            
            Divider()
            
            List(person.posts) { post in
                NavigationLink(destination: PostDetail(post: post, person: dataViewModel.person(for: post))){
                    VStack(spacing: 15){
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
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text(post.ciap)
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 16))
                            }.padding(EdgeInsets(top: -20, leading: 60, bottom: 0, trailing: 0))
                            
                            HStack(spacing: 6){
                                HStack(spacing: -13){
                                    URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                        .frame(width: 24, height: 24)
                                        .clipShape(Circle())
                                    
                                    URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                        .frame(width: 24, height: 24)
                                        .clipShape(Circle())
                                    
                                    URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                        .frame(width: 24, height: 24)
                                        .clipShape(Circle())
                                    
                                }
                                HStack(spacing: 24){
                                    HStack(spacing: 2){
                                        Image(systemName: "heart")
                                        Text(formatNumber(post.likes))
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                    HStack(spacing: 2){
                                        Image(systemName: "arrow.2.squarepath")
                                        Text(formatNumber(post.respeech))
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                    HStack(spacing: 2){
                                        Image(systemName: "message")
                                        Text(formatNumber(post.responseCount))
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                            }.padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 15))
                            HStack(){
                                ///untukk set width
                            }.frame(width: UIScreen.main.bounds.width - 40)
                                .padding(.bottom, 8)
                            Divider()
                        }.frame(width: UIScreen.main.bounds.width)
                    }
                    
                }.listRowSeparator(.hidden)
            }.listStyle(.plain)
            //        .navigationTitle(person.name)
//        }
    }
}
