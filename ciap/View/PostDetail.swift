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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                URLImage(urlString: person?.photouser ?? "")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                
                VStack(alignment: .leading) {
                    Text(person?.name ?? "")
                        .font(.title)
                    Text("ID: \(post.id)")
                        .font(.headline)
                }
            }
            
            Text("Background: \(post.background)")
                .foregroundColor(.secondary)
            Text("Date: \(post.date)")
                .foregroundColor(.secondary)
            Text("CIAP: \(post.ciap)")
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
