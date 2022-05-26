//
//  ConfigValues.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import Foundation

class ConfigValues {
    
    // Localization
    static let defaultLocalizationFile = "Localizable"
    
    static var localizationFile: String {
        if let configuration = Bundle.main.infoDictionary?["Configuration"] as? Dictionary<String, String> {
            if let fileName = configuration["LocalizationFile"] {
                return fileName
            }
        }
        return ConfigValues.defaultLocalizationFile
    }
    
    // Token
    static var tokenKey: String? {
        UserDefaults.standard.string(forKey: "token")
    }
}
