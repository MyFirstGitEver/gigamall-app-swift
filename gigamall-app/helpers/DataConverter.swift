//
//  DataConverter.swift
//  messenger-lite
//
//  Created by FVFH4069Q6L7 on 11/08/2023.
//

import Foundation

class DataConverter<T : Codable> {
    static func fromData(_ data : Data) throws -> T {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(T.self, from: data)
    }
    
    static func toData(_ object : T) throws -> Data {
        try JSONEncoder().encode(object)
    }
}
