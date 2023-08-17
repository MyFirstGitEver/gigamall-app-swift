//
//  CategoryMainView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 15/08/2023.
//

import SwiftUI

enum By : String {
    case mostPopular = "Theo đánh giá"
    case price = "Theo giá"
    case alphabet = "A-Z"
}

struct CategoryMainView: View {
    let twoColumnGridDefinition = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let allChoices : [By] = [.alphabet, .mostPopular, .price]
    let categoryName : String
    
    @State private var lowest = CGFLOAT_MAX
    @State private var range : CGFloat = 0.0
    
    @State private var fromRatio : CGFloat = 0.0
    @State private var toRatio : CGFloat = 1.0
    
    @State private var showsFilterDialog = false
    @State private var showsRange = false
    
    @State private var sortByStrategy : By = .alphabet
    @State private var topProducts : [Product] = [
    ]
    
    @State private var filtered : [Product] = [
    ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        topDisplay
                        
                        LazyVGrid(columns: twoColumnGridDefinition) {
                            ForEach(filtered) { topProduct in
                                ProductInListAllView(product: topProduct)
                            }
                        }
                        
                        Spacer()
                    }
                    .task {
                        loadProducts()
                    }
                }
                
                filterDialog
                    .padding(30)
                    .offset(x: showsFilterDialog ? 0 : -1000)
            }
        }.navigationBarBackButtonHidden()
    }
    
    var filterDialog : some View {
        VStack {
            Text("Lọc theo giá tiền...")
            TwoHeadSliderView(
                firstValue: $fromRatio,
                secondValue: $toRatio,
                onChangingValue: {
                    withAnimation(.spring()) {
                        filterBetween()
                        showsRange = true
                    }
                }, valueConverter: { $0 * range + lowest })
            
            Button(action: {
                withAnimation(.spring()) {
                    showsFilterDialog = false
                }
            }) {
                Text("Hoàn tất")
            }.padding(10)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 20)
    }
    
    var topDisplay: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 15, height: 20)
                }
                .foregroundColor(.white)
                
                Text(ByCategory.convertCateogryToString(category: categoryName))
                    .padding([.leading], 15)
                    .font(.system(size: 25))
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer()
                NavigationLink {
                    AllCategoriesView()
                } label:  {
                    HStack {
                        Image(systemName: "binoculars.fill")
                        Text("Tìm hiểu thêm")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
            .padding(10)
            .background(.green)
            
            HStack {
                Picker("", selection: $sortByStrategy) {
                    ForEach(allChoices, id: \.self) { text in
                        Text(text.rawValue)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
                
                if showsRange {
                    HStack {
                        Text(getRange())
                            .padding(10)
                            .background(.gray)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            showsRange = false
                        }) {
                            Image(systemName: "xmark.app.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Button(action: {
                    withAnimation(.spring()) {
                        showsFilterDialog = true
                    }
                }) {
                    Text("Lọc")
                        .bold()
                        .padding([.trailing], 15)
                }
            }
        }
    }
    
    func getRange() -> String {
        return lowest == CGFLOAT_MAX ? "": "\(Int(fromRatio * range + lowest))$ - \(Int(toRatio * range + lowest))$"
    }
    
    func filterBetween() {
        filtered = topProducts.filter {
            let fromDiff = range * fromRatio
            let toDiff = range * toRatio
            let diff = $0.price - lowest
            
            return
                diff > fromDiff && diff < toDiff
        }
    }
    
    // TODO: Delete this!
    func loadProducts() {
        topProducts = (0..<6).map {
            Product(
            name: "Quần lót nam đầy sức nam tính",
            description: "",
            imageLink: "https://res.cloudinary.com/dk8hbcln1/image/upload/v1672655936/meo4_bke2pl.jpg",
            price: CGFloat($0) * 20,
            starCount: 100)
        }
        
        filtered.reserveCapacity(topProducts.count)
        let lowest = topProducts.min(by: { $0.price < $1.price })!.price
        
        let highest = topProducts.max(by: { $0.price < $1.price })!.price
        
        topProducts.forEach { product in
            filtered.append(product)
        }
        
        self.lowest = lowest - 1
        range = highest - lowest + 2
    }
}

struct CategoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryMainView(categoryName: "tops")
    }
}
