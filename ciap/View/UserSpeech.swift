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
    
    var body: some View {
        List(person.posts) { post in
            NavigationLink(destination: PostDetail(post: post, person: dataViewModel.person(for: post))){
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.system(size: 16))
                        .bold()
                    Text(post.ciap)
                        .foregroundColor(.secondary)
                        .font(.system(size: 16))
                }
            }
            
        }
        .navigationTitle(person.name)
    }
}
