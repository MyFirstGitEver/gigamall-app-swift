//
//  Product.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import Foundation

struct Product : Identifiable {
    let id : UUID
    let name : String
    let description : String
    let imageLink : String
    let price : CGFloat
    let starCount: Int
    
    init(
        name: String,
        description: String,
        imageLink: String,
        price: CGFloat,
        starCount: Int) {
        self.id = UUID()
        
        self.name = name
        self.description = description
        self.imageLink = imageLink
        self.price = price
        self.starCount = starCount
    }
}
