//
//  UserEntity.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 17/08/2023.
//

import Foundation

struct UserEntity : Codable {
    var userDisplayName : String
    var url : String
    var starCount : Int
    
    init() {
        userDisplayName = ""
        url = ""
        starCount = 0
    }
}
