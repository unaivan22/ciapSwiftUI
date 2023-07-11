//
//  Model.swift
//  ciap
//
//  Created by una ivan on 07/07/23.
//

import Foundation

struct Person: Codable, Identifiable {
    let id: Int
    let name: String
    let photouser: String
    let posts: [Post]
}

struct Post: Codable, Identifiable, Comparable {
    let id: Int
    let background: String
    let fontbackground: String
    let date: String
    let ciap: String
    let fav: Int
    let loved: Bool
    let thumbhs: String
    let likes: Int
    let respeech: Int
    let comments: Int
    
    static func < (lhs: Post, rhs: Post) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if let lhsDate = dateFormatter.date(from: lhs.date), let rhsDate = dateFormatter.date(from: rhs.date) {
            return rhsDate <  lhsDate
        }
        return false
    }
}
