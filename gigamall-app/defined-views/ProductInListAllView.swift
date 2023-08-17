//
//  TopProductView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 15/08/2023.
//

import SwiftUI

struct ProductInListAllView: View {
    let product : Product
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.imageLink)) { image in
                       image
                           .resizable()
                           .frame(width: 150, height: 150)
                           
                   } placeholder: {
                       Color.gray
                   }
            Text("\(product.starCount) 🌟")
                .font(.system(size: 30))
                .bold()
            Text("\(product.name) **(\(product.price)$**)")
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
        }
    }
}

struct ProductInListAllView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInListAllView(product: Product(
            name: "Quần lót nam đầy sức nam tính",
            description: "",
            imageLink: "https://res.cloudinary.com/dk8hbcln1/image/upload/v1672655936/meo4_bke2pl.jpg",
            price: 15,
            starCount: 100))
    }
}
