//
//  ProductAPICaller.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 17/08/2023.
//

import Foundation

enum ProductAPICallerError : Error {
    case NETWORK_FAILURE
    case PARSER_ERROR
}
    

class ProductAPICaller {
    static let instance = ProductAPICaller()
    
    func getRandomProducts(
        onComplete: @escaping (Result<[ProductEntity], Error>) -> ()) {
        APICaller.callWithResult(
            urlPath: "\(LoginAndPort.content)/api/products/all",
            methodName: "GET",
            onComplete: { (data, response, err) in
                if response == nil || data == nil {
                    onComplete(.failure(ProductAPICallerError.NETWORK_FAILURE))
                    return
                }
                
                do {
                    let products = try DataConverter<[ProductEntity]>.fromData(data!)
                    onComplete(.success(products))
                } catch let err {
                    print(err.localizedDescription)
                    onComplete(.failure(ProductAPICallerError.PARSER_ERROR))
                }
            })
    }
}
