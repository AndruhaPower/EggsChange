//
//  Optional+Extension.swift
//  EggsChange
//
//  Created by Андрей Жуков on 20.03.2022.
//

import Foundation

extension Optional {
    
    var isExist: Bool {
        switch self {
        case .none: return false
        case .some: return true
        }
    }
}
