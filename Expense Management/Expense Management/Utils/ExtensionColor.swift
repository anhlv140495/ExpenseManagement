//
//  ExtensionUIColor.swift
//  VayMuonP4New
//
//  Created by Sơn Bùi on 3/22/19.
//  Copyright © 2019 Sơn Bùi. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let pink1 = UIColor(r: 254, g: 81, b: 150)
       static let pink2 = UIColor(r: 236, g: 73, b: 138)
       static let red3 = UIColor(r: 232, g: 93, b: 78)
       static let red4 = UIColor(r: 247, g: 112, b: 98)
       static let green1 = UIColor(r: 0, g: 227, b: 174)
       static let green2 = UIColor(r: 20, g: 203, b: 160)
       static let blue3 = UIColor(r: 37, g: 117, b: 252)
       static let blue4 = UIColor(r: 37, g: 109, b: 230)
       
       //celestial
       static let green3 = UIColor(r: 36, g: 210, b: 146)
       static let green4 = UIColor(r: 31, g: 197, b: 136)
       static let purple2 = UIColor(r: 194, g: 74, b: 182)
       static let purple3 = UIColor(r: 213, g: 88, b: 200)
       static let blue5 = UIColor(r: 2, g: 80, b: 197)
       static let blue6 = UIColor(r: 43, g: 88, b: 155)
       static let darkRed1 = UIColor(r: 184, g: 56, b: 123)
       static let darkRed2 = UIColor(r: 212, g: 63, b: 141)
       
       // scarlet azure
       static let dBlue = UIColor(r: 192, g: 108, b: 132)
       static let dRed = UIColor(r: 53, g: 92, b: 125)
       static let dGold = UIColor(r: 232, g: 188, b: 118)
       static let lBlue = UIColor(r: 58, g: 101, b: 137)
       static let lRed = UIColor(r: 201, g: 129, b: 150)
       static let lGold = UIColor(r: 233, g: 189, b: 124)
    
    static let grayBackground = UIColor(r: 40, g: 40, b: 40)
    static let offBlackBackground = UIColor(r: 25, g: 25, b: 25)
    static let cellLight = UIColor(r: 246, g: 246, b: 246)
    static let cellDark = UIColor(r: 35, g: 35, b: 35)
    static let cellPureDark = cellDark.adjust(by: -3.75)
    static let cellHighlightDefault = UIColor(r: 209, g: 209, b: 214)
    static let cellHighlightDark = UIColor(r: 58, g: 58, b: 60)
    
    // default
    static let lightRed = UIColor(r: 254, g: 129, b: 118)
    static let lightRedBack = UIColor(r: 221, g: 86, b: 75)
    static let medRed = UIColor(r: 254, g: 151, b: 114)
    static let lightOrange = UIColor(r: 254, g: 171, b: 109)
    static let medOrange = UIColor(r: 253, g: 193, b: 104)
    static let lightYellow = UIColor(r: 254, g: 215, b: 119)
    static let medYellow = UIColor(r: 253, g: 224, b: 119)
    static let lightGreen = UIColor(r: 192, g: 223, b: 129)
    static let medGreen = UIColor(r: 155, g: 215, b: 112)
    static let heavyGreen = UIColor(r: 121, g: 190, b: 168)
    static let lightBlue = UIColor(r: 96, g: 156, b: 225)
    static let medBlue = UIColor(r: 103, g: 143, b: 254)
    static let lightPurple = UIColor(r: 138, g: 138, b: 239)
    static let medPurple = UIColor(r: 144, g: 91, b: 236)
    // Main Color
    //11CA71
    static func mainColor() -> UIColor {
        return UIColor(red:0.07, green:0.79, blue:0.44, alpha:1.0)    }
    
    static func textContractColor() -> UIColor {
        return UIColor(red:0.31, green:0.45, blue:1.00, alpha:1.0)
    }
    
    // Color width Button in Create Loan Screen
    //B3B9C9
    static func borderColorButton() -> UIColor {
        return UIColor(red:0.70, green:0.73, blue:0.79, alpha:1.0)
    }
    
    // Color Text Color collection
    //6D748B
    static func textColorCollection() -> UIColor {
        return UIColor(red:0.43, green:0.45, blue:0.55, alpha:1.0)
    }
    
    //Color Select Cell Collection
    //11CA71
    static func selectCollectionCell() -> UIColor {
        return UIColor(red:0.07, green:0.79, blue:0.44, alpha:1.0)
    }
    static var myAppBlue: UIColor {
        return UIColor(red: 0, green: 0.2, blue: 0.9, alpha: 1)
    }
    //Color Checked View
    //BEC3D1
    static func checkedColor () -> UIColor {
        return UIColor(red:0.75, green:0.76, blue:0.82, alpha:1.0)
    }
    
    //Color Text
    //5E6372
    static func textAddBank() -> UIColor {
        return UIColor(red:0.37, green:0.39, blue:0.45, alpha:1.0)
    }
    
    static func blueMainColor() -> UIColor{
        UIColor(red: 0.24, green: 0.38, blue: 1.00, alpha: 1.00)

    }
    //Text Color Guide Camera
    //505565
    static func textGuideCameraColor() -> UIColor {
        return UIColor(red:0.31, green:0.33, blue:0.40, alpha:1.0)
    }
    
    //Color Status CMND Cell
    //E2E4EA
    static func colorStatusCollectionCell() -> UIColor {
        return UIColor(red:0.89, green:0.89, blue:0.92, alpha:1.0)
    }
    
    //Color Text Guide Regular
    //878D9E
    static func textGuideRegular() -> UIColor {
        return UIColor(red:0.53, green:0.55, blue:0.62, alpha:1.0)
    }
    
    //Color Button Apply
    //999EB0
    static func customColorApply() -> UIColor {
        return UIColor(red:0.60, green:0.62, blue:0.69, alpha:1.0)
    }
    
    //Color Button Continue
    // E5E5EC
    static func colorButtonContinue() -> UIColor {
        return UIColor(red:0.90, green:0.90, blue:0.93, alpha:1.0)
    }
    
    //6979F8
    static func textUpdateCellColor() -> UIColor {
        return UIColor(red:0.41, green:0.47, blue:0.97, alpha:1.0)
    }
    
    //FFBD00
    static func textSoHoKhauColor() -> UIColor {
        return UIColor(red:1.00, green:0.74, blue:0.00, alpha:1.0)
    }
    
    //F9F9F9
    static func bgGrayColor() -> UIColor {
       return UIColor(red:0.48, green:0.48, blue:0.51, alpha:1.0)
    }
    
    static func graycColor() -> UIColor {
        return UIColor(red:230/250, green:230/250, blue:230/250, alpha:1.0)
    }
    
    //FE5050
    static func customRedColor() -> UIColor {
        return UIColor(red:1.00, green:0.31, blue:0.31, alpha:1.0)
    }
    
    //F9F9F9
    static func bgOrangeColor() -> UIColor {
        return UIColor(red:0.97, green:0.58, blue:0.12, alpha:1.0)
    }
    
    //232735
    static func textHanTra() -> UIColor {
        return UIColor(red:0.14, green:0.15, blue:0.21, alpha:1.0)
    }
    
    //FFBD00
    
    static func textYellowColor() -> UIColor {
       return UIColor(red:1.00, green:0.74, blue:0.00, alpha:1.0)
    }
    
    //A1A4B1
    static func borderTextView() -> UIColor {
        return UIColor(red:0.63, green:0.64, blue:0.69, alpha:1.0)
    }
    
    //595959
    static func textNewDashBoard() -> UIColor {
        return UIColor(red:0.35, green:0.35, blue:0.35, alpha:1.0)
    }
    
    //F7941E
    static func customOranges() -> UIColor {
        return UIColor(red:0.97, green:0.58, blue:0.12, alpha:1.0)
    }
    
    //0A543E
    static func customTextSayHello() -> UIColor{
        return UIColor(red:0.04, green:0.33, blue:0.24, alpha:1.0)
    }
    
    //0E9347
    static func customNameSayHello() -> UIColor {
        return UIColor(red:0.05, green:0.58, blue:0.28, alpha:1.0)
    }
    
    //E2E6E9
    static func customViewTextPassword() -> UIColor {
        return UIColor(red:0.89, green:0.90, blue:0.91, alpha:1.0)
    }
    
    
    
    static func redColorWeb() -> UIColor {
        return UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 1.00)

    }
    
    static func orangeColorWeb() -> UIColor {
        return UIColor(red: 0.86, green: 0.24, blue: 0.00, alpha: 1.00)
    }
    
    
    static func yellowColorWeb() -> UIColor {
        return UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)

    }
    
    static func greenColorWeb() -> UIColor {
        return UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
    }
    
    static func navyColorWeb() -> UIColor {
        return UIColor(red: 0.00, green: 0.42, blue: 0.46, alpha: 1.00)
    }
    
    static func blueColorWeb() -> UIColor {
        return UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
    }
    
    
    static func boldBlueColorWeb() -> UIColor {
        return UIColor(red: 0.00, green: 0.30, blue: 0.81, alpha: 1.00)

    }
    
    static func purpleColorWeb() -> UIColor {
        return UIColor(red: 0.33, green: 0.00, blue: 0.92, alpha: 1.00)
    }
    
    static func pinkColorWeb() -> UIColor {
        return UIColor(red: 0.92, green: 0.59, blue: 0.58, alpha: 1.00)

    }
    
    static func lightPinkColorWeb() -> UIColor {
        return UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
    }
    
    static func lightYellowColorWeb() -> UIColor {
        return UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 1.00)

    }
    
    
    static func lightGreenColorWeb() -> UIColor {
        return UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)
    }
    
    static func lightBlueColorWeb() -> UIColor {
      return   UIColor(red: 0.75, green: 0.85, blue: 0.86, alpha: 1.00)

    }
    
    static func lightBlueColorWeb2() -> UIColor {
      return   UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
    }
    
    static func lightPurpleColorWeb() -> UIColor {
      return   UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00)

    }
    
    static func lightPurpleColorWeb2() -> UIColor {
      return   UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)


    }
    
    static func LIGHTCORAL() -> UIColor {
      return   UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)


    }
    
    static func DARKSALMON() -> UIColor {
      return   UIColor(red: 0.91, green: 0.59, blue: 0.48, alpha: 1.00)
    }
    
    static func CRIMSON() -> UIColor {
      return   UIColor(red: 0.86, green: 0.08, blue: 0.24, alpha: 1.00)
    }
    
    static func DARKRED() -> UIColor {
      return   UIColor(red: 0.55, green: 0.00, blue: 0.00, alpha: 1.00)
    }
    
    static func DEEPPINK() -> UIColor {
      return   UIColor(red: 1.00, green: 0.08, blue: 0.58, alpha: 1.00)
    }
    
    static func TOMATO() -> UIColor {
      return   UIColor(red: 1.00, green: 0.39, blue: 0.28, alpha: 1.00)
    }
    
    static func DARKORANGE() -> UIColor {
      return   UIColor(red: 1.00, green: 0.55, blue: 0.00, alpha: 1.00)
    }
    
    static func GOLD() -> UIColor {
      return   UIColor(red: 1.00, green: 0.84, blue: 0.00, alpha: 1.00)
    }
    
    static func DARKKHAKI() -> UIColor {
      return   UIColor(red: 0.74, green: 0.72, blue: 0.42, alpha: 1.00)
    }
    
    static func MEDIUMORCHID() -> UIColor {
      return   UIColor(red: 0.73, green: 0.33, blue: 0.83, alpha: 1.00)
    }
    
    static func MEDIUMSLATEBLUE() -> UIColor {
      return   UIColor(red: 0.48, green: 0.41, blue: 0.93, alpha: 1.00)
    }
    
    static func LIMEGREEN() -> UIColor {
      return   UIColor(red: 0.20, green: 0.80, blue: 0.20, alpha: 1.00)
    }
    
    static func MEDIUMSEAGREEN() -> UIColor {
      return   UIColor(red: 0.24, green: 0.70, blue: 0.44, alpha: 1.00)
    }
    
    static func DODGERBLUE() -> UIColor {
      return   UIColor(red: 0.12, green: 0.56, blue: 1.00, alpha: 1.00)
    }
    
    
    static func MIDNIGHTBLUE() -> UIColor {
      return   UIColor(red: 0.10, green: 0.10, blue: 0.44, alpha: 1.00)
    }
    
    static func CHOCOLATE() -> UIColor {
      return   UIColor(red: 0.82, green: 0.41, blue: 0.12, alpha: 1.00)
    }
}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage))
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        }
        return nil
    }
}
