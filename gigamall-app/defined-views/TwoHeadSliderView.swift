//
//  TwoHeadView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 16/08/2023.
//

import SwiftUI

struct TwoHeadSliderView: View {
    @Binding var firstValue : CGFloat
    @Binding var secondValue : CGFloat
    
    @State private var showsFirst : Bool = false
    @State private var showsSecond : Bool = false
    
    @State private var firstValueOnDrag: CGFloat = 0.0
    @State private var secondValueOnDrag: CGFloat = 0.0
    
    let onChangingValue : () -> ()
    let valueConverter : (CGFloat) -> (CGFloat)
    
    var body: some View {
        GeometryReader { infoContainer in
            ZStack {
                HStack(spacing: 0){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: firstValue * infoContainer.size.width,height: 3)
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: (secondValue - firstValue) * infoContainer.size.width, height: 3)
                        .foregroundColor(.blue)
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 3)
                }
                
                Circle()
                    .shadow(radius: 15)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .position(CGPoint(x:infoContainer.size.width * firstValue, y: infoContainer.size.height / 2))
                    .gesture(DragGesture(
                        minimumDistance: 0,
                        coordinateSpace: .local)
                        .onChanged { info in
                            if info.location.x < 0 {
                                return
                            }
                            
                            self.firstValue = min(
                                info.location.x / infoContainer.size.width, secondValue)
                            onChangingValue()
                            showsFirst = true
                            firstValueOnDrag = valueConverter(firstValue)
                        }
                        .onEnded { _ in
                            showsFirst = false
                        })
                
                Text("\(Int(firstValueOnDrag))")
                    .position(CGPoint(x:infoContainer.size.width * firstValue, y: infoContainer.size.height / 2 + 30))
                    .opacity(showsFirst ? 1 : 0)
                
                Text("\(Int(secondValueOnDrag))")
                    .position(CGPoint(x:infoContainer.size.width * secondValue, y: infoContainer.size.height / 2 + 30))
                    .opacity(showsSecond ? 1 : 0)
                
                Circle()
                    .shadow(radius: 15)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .position(CGPoint(x:infoContainer.size.width * secondValue, y: infoContainer.size.height / 2))
                    .gesture(DragGesture(
                        minimumDistance: 0,
                        coordinateSpace: .local)
                        .onChanged { info in
                            if info.location.x > infoContainer.size.width {
                                return
                            }
                            
                            self.secondValue = max(firstValue, info.location.x / infoContainer.size.width)
                            onChangingValue()
                            showsSecond = true
                            secondValueOnDrag = valueConverter(secondValue)
                        }
                        .onEnded { _ in
                            showsSecond = false
                        })
            }
        }.frame(maxHeight: 100)
    }
}

struct TwoHeadView_Previews: PreviewProvider {
    static var previews: some View {
        TwoHeadSliderView(
            firstValue: .constant(0.1),
            secondValue: .constant(0.7),
            onChangingValue: {
                
            },
            valueConverter: { $0 })
    }
}
