//
//  ImageRender.swift
//  ciap
//
//  Created by una ivan on 07/07/23.
//
import SwiftUI

struct URLImage: View {
    let urlString: String
    
    var body: some View {
        if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "person.fill")
                .resizable()
        }
    }
}
