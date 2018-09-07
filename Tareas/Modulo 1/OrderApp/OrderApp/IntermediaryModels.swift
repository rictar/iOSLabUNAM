//
//  IntermediaryModels.swift
//  OrderApp
//
//  Created by Ricardo Yepez on 06/09/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
