//
//  Item.swift
//  FYNutrition
//
//  Created by Riccardo Washington on 8/25/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

class Item: Codable {
    var name: String
    var isChecked: Bool
    
    init(name: String, isChecked: Bool = false) {
        self.name = name
        self.isChecked = isChecked
    }
    
    func toggleCheck() -> Item {
        return Item(name: name, isChecked: !isChecked)
    }
    
    static func fake(_ count: Int) -> [Item] {
        var items = [Item]()
        
        for i in 0...count {
            let item = Item(name: "Item \(i)", isChecked: i % 2 == 0)
            items.append(item)
        }
        return items
    }
}

extension Array where Element == ShoppingList {
    func save() {
        let data = try? JSONEncoder().encode(self)
        UserDefaults.standard.set(data, forKey: String(describing: Element.self))
    }
    
    static func load() -> [Element] {
        if let data = UserDefaults.standard.value(forKey: String(describing: Element.self)) as? Data,
            let elements = try? JSONDecoder().decode([Element].self, from: data) {
            for element in elements {
                element.onUpdate = elements.save
            }
            return elements
        }
        return []
    }
}
