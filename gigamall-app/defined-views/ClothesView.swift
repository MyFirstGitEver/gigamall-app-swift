//
//  ClothesView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

struct ClothesView: View {
    let product : Product
    
    var body: some View {
        VStack{
            Text("\(product.name) (\(product.price)$)")
                .bold()
                .font(.system(size: 20))
                .padding(10)
            
            AsyncImage(url: URL(string: product.imageLink)) { image in
                       image
                           .resizable()
                           .scaledToFit()
                           
                   } placeholder: {
                       Color.gray
                   }
            
            Text(product.description)
                .foregroundColor(.gray)
                .padding([.top], 20)
        }
    }
}

struct ClothesView_Previews: PreviewProvider {
    static var previews: some View {
        ClothesView(product: Product(
            name: "Đĩa DVD giá rẻ",
            description: "Không thể rẻ hơn với đĩa DVD đa chức năng",
            imageLink: "adas",
            price: 15, starCount: 15))
    }
}
