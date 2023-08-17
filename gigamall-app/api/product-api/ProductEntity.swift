//
//  ProductEntity.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 17/08/2023.
//

import Foundation

struct ProductEntity : Codable {
    let id : Int
    let sold : Int
    let star : Int
    
    let title : String
    let type : String
    let url : String
    let description : String
    let price : Double
}
