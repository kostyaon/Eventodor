//
//  +UIColor.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 24.05.22.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Method's
    class func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
        .init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    // MARK: - Black
    class var labelColor: UIColor {
        .rgba(83, 92, 94)
    }
}
