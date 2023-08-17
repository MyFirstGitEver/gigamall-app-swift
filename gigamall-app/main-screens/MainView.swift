//
//  ContentView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue : CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct MainView: View {
    @State private var showsMiddleDisplay : Bool = false
    @State private var selection : Int = 0
    
    @State private var hottestProducts : [Product] = [
    ]
    
    @State private var menClothes : [Product] = [
    ]
    
    @State private var womenClothes : [Product] = [
    ]
    @State private var randomProducts : [Product] = [
    ]
    
    @State private var displayProduct : Product? = nil
    
    private let threeColGridDefinition = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let searchButtonBgColor =
        Color(red: 183 / 255,
              green: 182 / 255,
              blue: 182 / 255)
    
    var body: some View {
        NavigationStack {
            VStack {
                topDisplay
                Divider()
                    .padding([.bottom], 15)
                ScrollView {
                    LazyVStack {
                        viewPager
                        hottestProductsView
                        clothesProductsView
                        byCategoryView
                        maybeYouLike
                    }
                    .background(GeometryReader { proxy in
                        Color.clear.preference(key: ViewOffsetKey.self, value: -proxy.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) {
                        if $0 <= 0 {
                            withAnimation(.spring()) {
                                showsMiddleDisplay = false
                            }
                        }
                        else {
                            withAnimation(.spring()) {
                                showsMiddleDisplay = true
                            }
                        }
                    }
                }.coordinateSpace(name: "scroll")
            }
            .onAppear {
                loadHottest()
                loadMenClothes()
                loadWomenClothes()
                loadRandom()
            }
        }
    }
    
    var maybeYouLike : some View {
        VStack {
            buildTitleTextview(title: "Có thể bạn sẽ thích...")
            LazyVGrid(columns: threeColGridDefinition, spacing: 30) {
                ForEach(randomProducts) { product in
                    RecommendedProductView(product: product)
                }
            }
        }
    }
    
    var byCategoryView : some View {
        VStack {
            buildTitleTextview(title: "Theo chủ đề")
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(ByCategory.cateogories, id: \.self) { category in
                        NavigationLink {
                            CategoryMainView(categoryName: category)
                        } label: {
                            ByCategoryInMainView(categoryName: category)
                                .padding([.trailing], 20)
                        }
                    }
                }
            }
        }
    }
    
    var clothesProductsView : some View {
        VStack {
            buildTitleTextview(title: "Men clothes 👕")
            
            TabView {
                ForEach(menClothes) { product in
                    NavigationLink {
                        ProductMainView(product: product)
                    } label: {
                        ClothesView(product: product)
                    }
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                buildTitleTextview(title: "Women clothes 👕")
                Spacer()
            }
            
            TabView {
                ForEach(womenClothes) { product in
                    Button(action: {
                        displayProduct = product
                    }) {
                        ClothesView(product: product)
                    }
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    var hottestProductsView : some View {
        VStack {
            HStack {
                buildTitleTextview(title: "Cháy hàng 🔥")
                    .foregroundColor(.orange)
                Spacer()
            }
            TabView {
                ForEach(hottestProducts) { product in
                    HottestProductView(product: product)
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    var viewPager : some View {
        TabView {
            Image("ad1")
                .resizable()
                .frame(maxWidth: .infinity)
                .padding([.horizontal], 30)
                .tag(0)
            Image("ad2")
                .resizable()
                .frame(maxWidth: .infinity)
                .padding([.horizontal], 30)
                .tag(0)
            Image("ad3")
                .resizable()
                .frame(maxWidth: .infinity)
                .padding([.horizontal], 30)
                .tag(0)
        }
        .frame(height: 140)
        .tabViewStyle(PageTabViewStyle())
    }
    
    var topDisplay : some View {
        ZStack {
            HStack {
                Image("gigamall")
                    .resizable()
                    .frame(width: 55, height: 45)
                    .padding([.leading], 10)
                
                if(showsMiddleDisplay) {
                    
                    Spacer()
                }
            }
            
            Button(action: {
                
            }) {
                Text("Tìm kiếm sản phẩm. Thời trang, .etc")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(searchButtonBgColor)
                    .opacity(showsMiddleDisplay ? 1 : 0)
                    .cornerRadius(15)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(15)
                }
                .foregroundColor(.black)
            }
        }
    }
    
    func buildTitleTextview(title: String) -> some View {
        HStack {
            Text(title)
                .padding([.leading, .top], 10)
                .font(.system(size: 20))
                .foregroundColor(.orange)
            Spacer()
        }
    }
    
    //TODO: Delete this
    func loadMenClothes() {
        if menClothes.count == 0 {
            for _ in 0..<10 {
                menClothes.append(                Product(
                    name: "Quần nam lịch lãm",
                    description: "Quần nam thời trang sành điệu và phong cách",
                    imageLink: "",
                    price: 15, starCount: 100))
            }
        }
    }
    
    //TODO: Delete this
    func loadWomenClothes() {
        if womenClothes.count == 0 {
            for _ in 0..<10 {
                womenClothes.append(                Product(
                    name: "Quần nam lịch lãm",
                    description: "Quần nam thời trang sành điệu và phong cách",
                    imageLink: "adas",
                    price: 15, starCount: 150))
            }
        }
    }
    
    
    //TODO: delete this
    func loadHottest() {
        if hottestProducts.count == 0 {
            for _ in 0..<10 {
                hottestProducts.append(                Product(
                    name: "Đĩa DVD giá rẻ",
                    description: "Không thể rẻ hơn với đĩa DVD đa chức năng",
                    imageLink: "adas",
                    price: 15, starCount: 15))
            }
        }
    }
    
    func loadRandom() {
        if randomProducts.count == 0 {
            for _ in 0..<10 {
                randomProducts.append(Product(name: "Mỹ phẩm cho nữ giới", description: "Loại mỹ phẩm tốt nhất thế giới", imageLink: "", price: 15, starCount: 15))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
