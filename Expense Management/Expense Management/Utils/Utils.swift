//
//  Utils.swift
//  Expense Management
//
//  Created by LE VIET ANH on 11/25/20.
//

import Foundation
import  UIKit
class Utils: NSObject {
    
   
    static func addLeftIconTextField(icon : String!, textField : UITextField) {
        let btnIcon = UIButton(type: .custom)
        btnIcon.setImage(UIImage.init(named: icon), for: .normal)
        btnIcon.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        btnIcon.contentHorizontalAlignment = .center
        btnIcon.isUserInteractionEnabled = false
        textField.leftView = btnIcon
        textField.leftViewMode = .always
    }
    
    
    
}

extension Utils {
    static func resizeImage(image : UIImage) -> (UIImage) {
        var imgData = image.jpegData(compressionQuality: 1.0)
        var scale: CGFloat = 1.0
        while (imgData?.count)! > 150000{
            scale = scale - 0.1
            if scale <= 0.1 {
                imgData = image.jpegData(compressionQuality: 0.005)
                print(imgData?.count)
                break
            }
            imgData = image.jpegData(compressionQuality: scale)
        }
        
        let img = UIImage(data: imgData!)
        return img!
    }
    
    
    public static func formatMoney( money : Float) -> String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 0
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = ""
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        return currencyFormatter.string(from: NSNumber(value:Float64(money)))!
    }
    
    
    public static func  convertDate(date : String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy"
        
        if let dateFormat = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: dateFormat)
        }else {
            return ""
        }
    }
    
}

extension Utils {
    /*
     Formatter định dạng của số tiền
     */
    static func convertNumberToStringFormatNumber(number : Int) -> String {
        let fmt : NumberFormatter = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 0
        var str = fmt.string(from: NSNumber(value: number))
        
        if str?.range(of: ".") != nil {
            str = str?.replacingOccurrences(of: ".", with: ",")
        }
        return str!
    }
    
    static func convertFloatNumberToStringFormatNumber(number : Float) -> String {
          let fmt : NumberFormatter = NumberFormatter()
          fmt.numberStyle = .decimal
          fmt.maximumFractionDigits = 0
          var str = fmt.string(from: NSNumber(value: number))
          
          if str?.range(of: ".") != nil {
              str = str?.replacingOccurrences(of: ".", with: ",")
          }
          return str!
      }
    
    static func convertDoubleNumberToStringFormatNumber(number : Double) -> String {
          let fmt : NumberFormatter = NumberFormatter()
          fmt.numberStyle = .decimal
          fmt.maximumFractionDigits = 0
          var str = fmt.string(from: NSNumber(value: number))
          
          if str?.range(of: ".") != nil {
              str = str?.replacingOccurrences(of: ".", with: ",")
          }
          return str!
      }
}







extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func scale(by scale: CGFloat) -> UIImage? {
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return resize(targetSize: scaledSize)
    }
}

extension CGSize {
    static let thumbnail:CGSize = CGSize(width: 50, height:50)
}


extension String {
   
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}
