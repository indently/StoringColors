//
//  ContentView.swift
//  StoringColors
//
//  Created by Federico on 24/02/2022.
//

import SwiftUI
import UIKit
import Foundation

class ColorData {
    private var COLOR_KEY = "COLOR_KEY"
    private let userDefaults = UserDefaults.standard
    
    func saveColor(color: Color) {
        // Convert the color into RGB
        let color = UIColor(color).cgColor
        
        // Save the RGB into an array
        if let components = color.components {
            userDefaults.set(components, forKey: COLOR_KEY)
            
            print("Colour saved!")
        }
    }
    
    func loadColor() -> Color{
        // Get the RGB array
        guard let array = userDefaults.object(forKey: COLOR_KEY) as? [CGFloat] else { return Color.black }
        
        // Create a color from the RGB array
        let c = Color(.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
        
        print("Colour loaded!")
        return c
    }
}

struct ContentView: View {
    @State private var color: Color = Color.black
    private var colorData = ColorData()
    
    var body: some View {
        VStack(spacing: 10) {
            
            ColorPicker("Pick a color:", selection: $color)
            
            Rectangle()
                .frame(height: 200)
                .foregroundColor(color)
                .cornerRadius(20)
                .padding()
            
            Button("Save colour") {
                colorData.saveColor(color: color)
            }
            Spacer()
        }
        .onAppear {
            color = colorData.loadColor()
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
