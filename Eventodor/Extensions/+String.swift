//
//  +String.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import Foundation
import UIKit

extension String {
    
    func localized() -> String {
        var localizedString = NSLocalizedString(self, tableName: ConfigValues.localizationFile, comment: "")
        if localizedString == self {
            localizedString = NSLocalizedString(self, tableName: ConfigValues.defaultLocalizationFile, comment: "")
        }
        localizedString = localizedString.replacingOccurrences(of: "%s", with: "%@")
        localizedString = localizedString.replacingOccurrences(of: "$s", with: "$@")
        return localizedString
    }
    
    func addLineSpacing(spacing: CGFloat, textAllignment: NSTextAlignment) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = textAllignment
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
}
