//
//  SCColor.swift
//  SCTrade
//
//  Created by Mark on 13/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import Foundation
import UIKit

struct SCColor {
    
    static let clear   = UIColor.clear
    static let white   = UIColor.white
    
    static let darkPurple = getColor(hexInt: 0x443864)
    static let deepDark = getColor(hexInt: 0x111d2e)
    
    static let lightGreen = getColor(hexInt: 0x3cde5a)
    static let lightRed = getColor(hexInt: 0xff3768)
    
    static let superDark = getColor(hexInt: 0x1d293a)
    
    static let slowBlue = getColor(hexInt: 0x2d3e57)
    static let middleBlue = getColor(hexInt: 0x7795c8)
    
    static let lightWhite = getColor(hexInt: 0xfafafa)
    
    // HEX related
    private static func getColor(hexInt: Int,
                                 alpha: Double = 1.0) -> UIColor {
        
        let red: Int = (hexInt >> 16) & 0xFF
        let green: Int = (hexInt >> 8) & 0xFF
        let blue: Int = hexInt & 0xFF
        
        return SCColor.getColor(red: red,
                                 green: green,
                                 blue: blue,
                                 alpha: alpha)
    }
    
    // RGB related
    private static func getColor(red: Int,
                                 green: Int,
                                 blue: Int,
                                 alpha: Double = 1.0) -> UIColor {
        
        if SCColor.isValidRGBCode(red)
            && SCColor.isValidRGBCode(green)
            && SCColor.isValidRGBCode(blue)
            && SCColor.isValidAlpha(alpha) {
            
            return UIColor(red: CGFloat(red) / 255.0,
                           green: CGFloat(green) / 255.0,
                           blue: CGFloat(blue) / 255.0,
                           alpha: CGFloat(alpha))
        }
        
        return UIColor.clear
    }
    
    private static func isValidRGBCode(_ code: Int) -> Bool {
        return (code >= 0 && code <= 255)
    }
    
    private static func isValidAlpha(_ alpha: Double) -> Bool {
        return (alpha >= 0.0 && alpha <= 1.0)
    }
}
