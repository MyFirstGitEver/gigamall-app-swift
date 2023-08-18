//
//  UserAPICaller.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 17/08/2023.
//

import Foundation

enum UserAPICallerError : Error {
    case LOGIN_FAILED
    case CONNECTION_FAILED
    case PARASE_ERROR
}

class UserAPICaller {
    static let instance = UserAPICaller()
    
    func login(
        userName : String,
        password : String,
        onComplete : @escaping (Result<UserEntity, Error>) -> ()) {
        let urlPath = "\(DomainAndPort.content)/api/user/login/\(password)/\(userName)"
            
        APICaller.callWithResult(
            urlPath: urlPath,
            methodName: "GET",
            onComplete: { (data, response, err) in
                if response == nil {
                    onComplete(.failure(UserAPICallerError.CONNECTION_FAILED))
                    return
                }
                
                let httpResponse = response as! HTTPURLResponse
                
                if httpResponse.statusCode == 404 {
                    onComplete(.failure(UserAPICallerError.LOGIN_FAILED))
                    return
                }
                
                do {
                    let user = try DataConverter<UserEntity>.fromData(data!)
                    onComplete(.success(user))
                } catch let err {
                    onComplete(.failure(UserAPICallerError.PARASE_ERROR))
                    print(err.localizedDescription)
                }
            })
    }
}
