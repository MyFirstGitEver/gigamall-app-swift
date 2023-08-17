//
//  ByCategoryView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

struct ByCategoryInMainView: View {
    let categoryName : String
    
    var body: some View {
        VStack {
            Image(categoryName)
                .resizable()
                .frame(width: 100, height: 100)
            Text(ByCategory.convertCateogryToString(category: categoryName))
        }
    }
}

struct ByCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ByCategoryInMainView(categoryName: "tops")
    }
}
