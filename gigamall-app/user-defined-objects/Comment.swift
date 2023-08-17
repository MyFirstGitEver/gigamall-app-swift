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
    
    init(attatchedUrl: String?) {
        id = UUID()
        commentId = 0
        contentInStar = 15
        contentInText = "Great idea! Good job!asdasdasdasdasdasdasdasdasassdasdasdasdasdaasdasdasasdsadasdasdasdasdasdasda"
        self.attatchedUrl = attatchedUrl
        sentDate = Date.now
        userDisplayName = "Gia Duc"
    }
}
