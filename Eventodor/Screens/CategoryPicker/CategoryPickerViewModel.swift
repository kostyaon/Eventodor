//
//  CategoryPickerViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

class CategoryPickerViewModel {
    
    var availableCategories: [CategoryEVENTODOR]?
    
    func getCategories() {
        if let path = Bundle.main.path(forResource: "Categories", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let jsonDecoder = JSONDecoder()
                if let categories = try? jsonDecoder.decode([CategoryEVENTODOR].self, from: data) {
                    availableCategories = categories
                }
            }
        }
    }
    
    func postCategories(_ indexes: [Int]) {
        if let path = Bundle.main.path(forResource: "Categories", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let jsonDecoder = JSONDecoder()
                if let categories = try? jsonDecoder.decode([CategoryEVENTODOR].self, from: data) {
                    indexes.map {
                        return $0 + 1
                    }
                }
            }
        }
    }
}
