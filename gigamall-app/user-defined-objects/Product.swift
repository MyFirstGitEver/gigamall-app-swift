//
//  Product.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import Foundation

struct Product : Identifiable {
    let id : UUID
    let productId : Int
    let name : String
    let description : String
    let imageLink : String
    let price : CGFloat
    let starCount: Int
    let sold : Int
    
    init(
        name: String,
        description: String,
        imageLink: String,
        price: CGFloat,
        starCount: Int) {
        self.id = UUID()
        
        self.productId = 0
        self.sold = 0
        self.name = name
        self.description = description
        self.imageLink = imageLink
        self.price = price
        self.starCount = starCount
    }
    
    init(entity : ProductEntity) {
        self.id = UUID()
        
        productId = entity.id
        name = entity.title
        description = entity.description
        imageLink = entity.url
        price = entity.price
        starCount = entity.star
        sold = entity.sold
    }
}
