//
//  ByCategory.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import Foundation

class ByCategory {
    static var cateogories = ["electronics", "women cares", "home-decoration", "tops", "women's clothing", "men's clothing" ]
    
    private static var dict = [
        "electronics": "Điện tử",
        "women cares" : "Mỹ phẩm",
        "home-decoration": "Trang trí",
        "tops": "Áo top",
        "women's clothing" : "Thời trang nữ",
        "men's clothing" : "Thời trang nam"
    ]
    
    static func convertCateogryToString(category: String) -> String {
        return dict[category]!
    }
}
