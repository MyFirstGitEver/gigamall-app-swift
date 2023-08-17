//
//  ConfirmationView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 15/08/2023.
//

import SwiftUI

enum Field : Int, Hashable {
    case FIRST = 0
    case SECOND = 1
    case THIRD = 2
    case FOURTH = 3
}

struct ConfirmationView: View {
    let gmail : String
    @State var firstDigit : String = ""
    @State var secondDigit : String = ""
    @State var thirdDigit : String = ""
    @State var fourthDigit : String = ""
    
    @State private var dummySignal = 0
    
    @FocusState private var focusArea : Field?
    
    var body: some View {
        ZStack {
            VStack {
                Image("gigamall")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(20)
                
                Text("Mã xác nhận đã được gửi tới **\(gmail)**. Vui lòng nhập mã")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.orange)
                    .padding([.top], 35)
                    .padding([.horizontal], 15)
                Spacer()
            }
            
            HStack {
                buildDigitReader(
                    digitBinder: _firstDigit, focusField: .FIRST)
                
                buildDigitReader(
                    digitBinder: _secondDigit, focusField:  .SECOND)
                
                buildDigitReader(
                    digitBinder: _thirdDigit, focusField: .THIRD)
                
                buildDigitReader(
                    digitBinder: _fourthDigit, focusField: .FOURTH)
            }
            
            VStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Hoàn tất đăng ký")
                }
            }
            Spacer()
        }
    }
    
    func buildDigitReader(
        digitBinder : State<String>, focusField : Field) -> some View {
        let binder = Binding<String>(
            get: {
                digitBinder.wrappedValue
            },
            set: {
                if $0.count == 1{
                    if dummySignal != 0 {
                        dummySignal -= 1
                        return
                    }
                    
                    digitBinder.wrappedValue = $0
                    focusArea = next(current: focusField)
                }
                else if($0.count == 0) {
                    if (digitBinder.wrappedValue.count == 1) {
                        focusArea = prev(current: focusField)
                        dummySignal = 5
                    }
                    
                    digitBinder.wrappedValue = $0
                }
                else {
                    let index = $0.index($0.startIndex, offsetBy: 1)
                    digitBinder.wrappedValue = String($0[..<index])
                }
            })
        
        return VStack {
            TextField("", text: binder)
                .font(.system(size: 25))
                .frame(width: 60, height:  60)
                .multilineTextAlignment(.center)
                .focused($focusArea, equals: focusField)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(.blue, lineWidth: 2)
        }
    }
    
    func prev(current: Field) -> Field {
        if focusArea == nil {
            return current
        }
        
        switch focusArea!{
        case .SECOND:
            return .FIRST
        case .THIRD:
            return .SECOND
        case .FOURTH:
            return .THIRD
        default:
            return .FIRST
        }
    }
    
    func next(current: Field) -> Field {
        if focusArea == nil {
            return current
        }
        
        switch focusArea!{
        case .FIRST:
            return .SECOND
        case .SECOND:
            return .THIRD
        case .THIRD:
            return .FOURTH
        default:
            return .FOURTH
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(gmail: "fordevok@gmail.com")
    }
}
