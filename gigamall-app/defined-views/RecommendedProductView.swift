//
//  RecommendedProductView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

struct RecommendedProductView: View {
    let product : Product
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.imageLink)) { image in
                       image
                           .resizable()
                           .scaledToFit()
                           
                   } placeholder: {
                       Color.gray
                   }
            
            Text(product.name)
                .font(.system(size: 23))
                .multilineTextAlignment(.center)
            Text("\(product.price)$")
                .bold()
        }
        .padding(30)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
}

struct RecommendedProductView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedProductView(
            product: Product(
                name: "Đĩa dvd",
                description: "",
                imageLink: "",
                price: 15, starCount: 10))
    }
}
