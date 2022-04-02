//
//  Array+Extension.swift
//  EggsChange
//
//  Created by Андрей Жуков on 13.03.2022.
//

import Foundation

extension Array where Element: Equatable {
    
    func removeDuplicates() -> [Element] {
        var result: [Element] = []
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        return result
    }
}

