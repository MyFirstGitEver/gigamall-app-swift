//
//  ByCategoryInListAllView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 16/08/2023.
//

import SwiftUI

struct ByCategoryInListAllView: View {
    let categoryName : String
    
    var body: some View {
        VStack {
            VStack {
                Image(categoryName)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text(ByCategory.convertCateogryToString(category: categoryName))
                
                NavigationLink {
                    CategoryMainView(categoryName: categoryName)
                } label: {
                    Text("Xem thêm về \(ByCategory.convertCateogryToString(category: categoryName))")
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding(30)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
}

struct ByCategoryInListAllView_Previews: PreviewProvider {
    static var previews: some View {
        ByCategoryInListAllView(categoryName: "tops")
    }
}
