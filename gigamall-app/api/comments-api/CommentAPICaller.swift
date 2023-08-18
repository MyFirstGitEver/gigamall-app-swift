//
//  CommentAPICaller.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 18/08/2023.
//

import Foundation

enum CommentAPICallerError : Error {
    case NETWORK_FAILURE
    case PARSER_ERROR
}

class CommentAPICaller {
    static let instance = CommentAPICaller()
    
    func getCommentsOfProduct(
        productId: Int,
        page: Int,
        onComplete: @escaping (Result<CommentsAndHeader, Error>) -> ()) {
            APICaller.callWithResult(
                urlPath:
                    "\(DomainAndPort.content)/api/comments/\(productId)/\(page)/true",
                methodName: "GET",
                onComplete: { (data, response, err) in
                    if data == nil || response == nil {
                        onComplete(.failure(CommentAPICallerError.NETWORK_FAILURE))
                        return
                    }
                    
                    do {
                        let comments = try DataConverter<[CommentEntity]>.fromData(data!)
                        
                        var commentNums = 0
                        let httpResponse = response as! HTTPURLResponse
                        if let totalHeader = httpResponse.allHeaderFields["total"] {
                            commentNums = Int(totalHeader as! String)!
                        }
                        
                        return onComplete(.success(
                            CommentsAndHeader(comments: comments, commentNums: commentNums)
                        ))
                    }
                    catch let err {
                        print(err.localizedDescription)
                        onComplete(.failure(CommentAPICallerError.PARSER_ERROR))
                    }
                })
        }
    
    func getRepliesOfComment(
        replyId: Int,
        page: Int,
        onComplete: @escaping (Result<[CommentEntity], Error>) -> ()) {
        APICaller.callWithResult(
            urlPath: "\(DomainAndPort.content)/api/comments/replies/\(replyId)/\(page)/true",
            methodName: "GET",
            onComplete: { (data, response, err) in
                if data == nil || response == nil {
                    onComplete(.failure(CommentAPICallerError.NETWORK_FAILURE))
                    return
                }
                
                do {
                    let comments = try DataConverter<[CommentEntity]>.fromData(data!)
                    return onComplete(.success(comments))
                }
                catch let err {
                    print(err.localizedDescription)
                    onComplete(.failure(CommentAPICallerError.PARSER_ERROR))
                }
            })
    }
}
