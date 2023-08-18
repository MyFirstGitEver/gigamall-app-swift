//
//  Comment.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 15/08/2023.
//

import Foundation


struct Comment :Identifiable {
    let id : UUID
    let commentId : Int
    let contentInStar : Int
    let contentInText : String
    let userDisplayName : String
    let attatchedUrl : String?
    let sentDate : Date
    let childCount : Int
    let level : Int
    
    init(entity: CommentEntity) {
        self.id = UUID()
        
        commentId = entity.id
        contentInStar = entity.contentInStar
        contentInText = entity.contentInText
        userDisplayName = entity.user.userDisplayName
        attatchedUrl = entity.attatchedUrl
        sentDate = entity.commentDate
        childCount = entity.childCount
        level = entity.level
    }
    
    init(attatchedUrl: String?, level: Int) {
        id = UUID()
        commentId = 0
        contentInStar = 15
        contentInText = "Great idea! Good job!asdasdasdasdasdasdasdasdasassdasdasdasdasdaasdasdasasdsadasdasdasdasdasdasda"
        self.attatchedUrl = attatchedUrl
        self.level = level
        sentDate = Date.now
        childCount = 3
        userDisplayName = "Gia Duc"
    }
}
