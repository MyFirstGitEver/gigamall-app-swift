//
//  ProductMainView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 15/08/2023.
//

import SwiftUI

struct ProductMainView: View {
    let product : Product
    @State private var commentsNum : Int = 0
    @State private var comments : [Comment] = []
    
    @Environment(\.dismiss) var dismiss
    
    private let topDisplayColor = Color(red: 118/255, green: 160 / 255, blue: 223 / 255)
    
    var body: some View {
        ScrollView {
            topDisplay
            middleDisplay
            
            LazyVStack {
                ForEach(comments) { comment in
                    CommentView(comment: comment)
                    Divider()
                }
                
                HStack {
                    Button(action: {
                    }) {
                        Text("Xem thêm \(comments.count) bình luận")
                            .padding([.leading], 10)
                            .underline()
                    }
                    Spacer()
                }
            }.onAppear {
                loadComments()
            }
            
            Spacer()
        }.navigationBarBackButtonHidden()
    }
    
    var middleDisplay : some View {
        VStack {
            AsyncImage(url: URL(string: product.imageLink)) { image in
                       image
                           .resizable()
                           .scaledToFit()
                           
                   } placeholder: {
                       Color.gray
                   }
            
            HStack {
                Text("\(Int(product.price)) $ (\(product.starCount) 🌟)")
                    .padding([.leading], 15)
                    .font(.system(size: 25))
                    .bold()
                Spacer()
            }
            
            Divider()
            
            Text(product.description)
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
            
            HStack {
                Text("Bình luận(\(commentsNum) bình luận)")
                    .font(.system(size: 17))
                    .bold()
                    .padding(10)
                Spacer()
            }
        }
    }
    
    var topDisplay : some View {
        HStack(alignment: .center){
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 15, height: 25)
                    .foregroundColor(.black)
            }
            Text(product.name)
                .font(.system(size: 20))
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                
            }) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            }
        }
        .padding(10)
        .background(topDisplayColor)
    }
    
    //TODO: Delete this!
    func loadComments() {
        comments = (0..<10).map { _ in
            return Comment(attatchedUrl: "https://res.cloudinary.com/dk8hbcln1/image/upload/v1672655936/meo4_bke2pl.jpg")
        }
    }
}

struct ProductMainView_Previews: PreviewProvider {
    static var previews: some View {
        ProductMainView(product: Product(
            name: "Váy nữ sành điệu",
            description: "Mẫu váy phong cách phù hợp cho mùa hè. Thích hợp cho những cô gái năng động", imageLink: "https://res.cloudinary.com/dk8hbcln1/image/upload/v1672655936/meo4_bke2pl.jpg", price: 15, starCount: 100))
    }
}
