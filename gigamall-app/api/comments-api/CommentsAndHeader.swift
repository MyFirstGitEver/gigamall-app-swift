//
//  CommentsAndHeader.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 18/08/2023.
//

import Foundation

struct CommentsAndHeader {
    let comments: [CommentEntity]
    let commentNums: Int
    
    init(comments: [CommentEntity], commentNums: Int) {
        self.comments = comments
        self.commentNums = commentNums
    }
}
