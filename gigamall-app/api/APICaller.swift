//
//  APICaller.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 17/08/2023.
//

import Foundation

class APICaller {
    static func callWithResult(
        urlPath : String,
        methodName: String,
        onComplete: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let url = URL(string: urlPath) {
            var request = URLRequest(url: url)
            request.httpMethod = methodName
            let session = URLSession.shared
            
            session.dataTask(with: request, completionHandler: onComplete).resume()
        }
    }
}
