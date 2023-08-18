//
//  CommentEntity.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 18/08/2023.
//

import Foundation

struct CommentEntity : Codable {
    let id : Int
    let level: Int
    let childCount : Int
    let contentInStar : Int
    let contentInText : String
    let attatchedUrl : String?
    let commentDate : Date
    
    let user : UserEntity
}
