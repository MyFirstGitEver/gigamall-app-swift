//
//  AllCategoriesView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 16/08/2023.
//

import SwiftUI

struct AllCategoriesView: View {
    @Environment(\.dismiss) var dismiss
    
    private let twoColumnDefinition = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    topDisplay
                        .padding([.bottom], 15)
                    
                    LazyVGrid(columns: twoColumnDefinition, spacing: 30) {
                        ForEach(ByCategory.cateogories, id: \.self) { categoryName in
                            ByCategoryInListAllView(categoryName: categoryName)
                        }
                    }
                    
                    Spacer()
                }.navigationBarBackButtonHidden()
            }
        }
    }
    
    var topDisplay: some View {
        ZStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding([.leading], 10)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            
            Text("Tất cả sản phẩm của chúng tôi")
                .bold()
                .font(.system(size: 20))
        }
    }
}

struct AllCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        AllCategoriesView()
    }
}
