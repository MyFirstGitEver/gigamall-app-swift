//
//  ProductView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

struct HottestProductView: View {
    let product : Product
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: product.imageLink)) { image in
                       image
                           .resizable()
                           .scaledToFit()
                           
                   } placeholder: {
                       Color.gray
                   }
            
            Text("\(product.name) (\(product.price)$)")
                .bold()
                .font(.system(size: 20))
                .padding(10)
            
            Text(product.description)
                .foregroundColor(.gray)
            
            NavigationLink {
                ProductMainView(product: product)
            } label: {
                Text("Xem thêm >")
                    .padding([.top], 10)
                    .font(.system(size: 20))
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        HottestProductView(product: Product(
            name: "Đĩa DVD giá rẻ",
            description: "Không thể rẻ hơn với đĩa DVD đa chức năng",
            imageLink: "adas",
            price: 15, starCount: 15))
    }
}
