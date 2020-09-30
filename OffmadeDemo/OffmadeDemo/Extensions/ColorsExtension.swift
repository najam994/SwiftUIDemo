//
//  ColorsExtension.swift
//  OffmadeDemo
//
//  Created by Syed Najam on 26/09/2020.
//

import Foundation
import SwiftUI

extension Color{
    public static var customAccentColor: Color {
            return Color(red: 0.0 / 255.0, green: 128.0 / 255.0, blue: 255.0 / 255.0)
        }
    
    public static var textHeadingColor: Color {
            return Color(red: 51.0 / 255.0, green: 0.0 / 255.0, blue: 25.0 / 255.0)
        }
    
    public static var textSubHeadingColor: Color {
        return Color(red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0)
        }
    
    public static var textBodyColor: Color {
            return Color(red: 51.0 / 255.0, green: 0.0 / 255.0, blue: 25.0 / 255.0)
        }
}
