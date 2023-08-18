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
    
    @State private var range : CGFloat = 3000
    
    @State private var fromRatio : CGFloat = 0.0
    @State private var toRatio : CGFloat = 1.0
    
    @State private var showsFilterDialog = false
    @State private var showsRange = false
    
    @State private var sortByStrategy : By = .alphabet
    @State private var productsOfCategory : [Product] = [
    ]
    
    @State private var showsWarning : Bool = false
    @State private var isLoadingImages : Bool = false
    @State private var containsMore : Bool = true
    @State private var pageCount : Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        topDisplay
                        productGrid
                        
                        Spacer()
                    }
                }
                .task {
                    if productsOfCategory.count == 0 {
                        loadProducts(refresh: true)
                    }
                }
                
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                    
                    Text("Không thể kết nối với máy chủ! Vui lòng kiểm tra đường truyền")
                        .multilineTextAlignment(.center)
                        .padding([.bottom], 10)
                    Button(action: {
                        dismiss()
                    }) {
                        Text("OK")
                    }
                }
                .padding(30)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20)
                .offset(x: showsWarning ? 0 : -1000)
                
                filterDialog
                    .padding(30)
                    .offset(x: showsFilterDialog ? 0 : -1000)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var productGrid : some View {
        LazyVGrid(columns: twoColumnGridDefinition) {
            ForEach(productsOfCategory) { product in
                ProductInListAllView(product: product)
                    .onAppear {
                        if product.id == productsOfCategory.last?.id && containsMore {
                            isLoadingImages = true
                        }
                    }
            }
            
            ProgressView().opacity(isLoadingImages ? 1 : 0)
        }.onChange(of: isLoadingImages) { _ in
            if containsMore {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    loadProducts(refresh: false)
                }
            }
        }
    }
    
    var filterDialog : some View {
        VStack {
            Text("Lọc theo giá tiền...")
            TwoHeadSliderView(
                firstValue: $fromRatio,
                secondValue: $toRatio,
                onChangingValue: {
                    withAnimation(.spring()) {
                        showsRange = true
                    }
                },
                onEndDragging: {
                    loadProducts(refresh: true)
                }, valueConverter: { $0 * range })
            
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
        return "\(Int(fromRatio * range))$ - \(Int(toRatio * range))$"
    }
    
    func convertStrategyToNumber() -> Int {
        switch sortByStrategy {
        case .mostPopular:
            return 1
        case .price:
            return 2
        case .alphabet:
            return 0
        }
    }
    
    func loadProducts(refresh: Bool) {
        if refresh {
            productsOfCategory.removeAll()
            pageCount = 0
            containsMore = true
        }
        
        ProductAPICaller.instance.getProductsByCategory(
            category: categoryName,
            page: pageCount,
            sortCondition: convertStrategyToNumber(),
            from: Int(range * fromRatio),
            to: Int(range * toRatio),
            onComplete: { result in
                do {
                    let newProductList = try result.get().map( {Product(entity: $0)} )
                    productsOfCategory.append(contentsOf: newProductList)
                    
                    if newProductList.count == 0 {
                        containsMore = false
                    }
                    else {
                        pageCount += 1
                    }
                    
                    isLoadingImages = false
                    
                } catch let err {
                    print(err.localizedDescription)
                    withAnimation(.spring()) {
                        showsWarning = true
                    }
                }
            })
    }
}

struct CategoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryMainView(categoryName: "tops")
    }
}
