//
//  Item.swift
//  FYNutrition
//
//  Created by Riccardo Washington on 8/25/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

struct Item {
    var name: String
    var isChecked: Bool = false
    
    static func fake(_ count: Int) -> [Item] {
        var items = [Item]()
        
        for i in 0...count {
            let item = Item(name: "Item \(i)", isChecked: i % 2 == 0)
            items.append(item)
        }
        return items
    }
}
