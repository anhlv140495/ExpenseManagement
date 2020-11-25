//
//  CategoryExtension.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

enum SWIconConfig {
    static let style: FontAwesomeStyle = .solid
    static let color: UIColor = .black
    static let defaultSize = CGSize(width: 128, height: 128)
}

extension UIImage {
    static func SWFontIcon(
        name: FontAwesome,
        size: CGSize = SWIconConfig.defaultSize) -> UIImage {

        return UIImage.fontAwesomeIcon(
            name: name,
            style: SWIconConfig.style,
            textColor: SWIconConfig.color,
            size: size
        )
    }
}

extension Categories {
    func iconImage(size: CGSize = SWIconConfig.defaultSize) -> UIImage? {
        guard !self.icon.isEmpty,
            let font = FontAwesome(rawValue: self.icon) else {
            let defaultIcon = self.direction > 0 ? "UpIcon" : "DownIcon"
            return UIImage(named: defaultIcon)
        }

        return UIImage.SWFontIcon(
            name: font,
            size: size
        )
    }
}
