//
//  +String.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import Foundation

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
}
