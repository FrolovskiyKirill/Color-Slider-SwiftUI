//
//  ContentView.swift
//  Color Slider SwiftUI
//
//  Created by Кирилл on 17.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    enum Field {
        case redField
        case greenField
        case blueField
    }
    
    @State private var sliderValueRed = Double.random(in: 0...255)
    @State private var sliderValueGreen = Double.random(in: 0...255)
    @State private var sliderValueBlue = Double.random(in: 0...255)
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .padding(.bottom)
                    .foregroundColor(Color(
                    red: sliderValueRed / 255.0,
                    green: sliderValueGreen / 255.0,
                    blue: sliderValueBlue / 255.0)
                )
                .frame(height: 200)
                
                ColorSliderView(value: $sliderValueRed, color: .red)
                    .focused($focusedField, equals: .redField)
                ColorSliderView(value: $sliderValueGreen, color: .green)
                    .focused($focusedField, equals: .greenField)
                ColorSliderView(value: $sliderValueBlue, color: .blue)
                    .focused($focusedField, equals: .blueField)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button(action: upTextField) {
                                Image(systemName: "chevron.up")
                            }
                            Button(action: downTextField) {
                                Image(systemName: "chevron.down")
                            }
                            Spacer()
                            Button("Done") {
                                focusedField = nil
                            }
                        }
                    }
                Spacer()
            }
            .padding()
        }
    }
    private func upTextField() {
        switch focusedField {
        case .redField:
            focusedField = .blueField
        case .greenField:
            focusedField = .redField
        default:
            focusedField = .greenField
        }
    }
    private func downTextField() {
        switch focusedField {
        case .redField:
            focusedField = .greenField
        case .greenField:
            focusedField = .blueField
        default:
            focusedField = .redField
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(color)
                .frame(width: 35)
            Slider(value: $value, in: 0...255).colorMultiply(color)
            TextField("", value: $value, formatter: NumberFormatter())
                .foregroundColor(color)
                .frame(width: 50)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
        }
    }
}
