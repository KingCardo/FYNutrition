//
//  ItemTableViewController.swift
//  FYNutrition
//
//  Created by Riccardo Washington on 8/25/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class ItemTableViewController: BaseTableViewController {
    
    var list: ShoppingList!
    
    var items: [Item] {
        get {
            return list.items
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()

    }
    
    private func setupNavBar() {
        self.title = list.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItems?.append(editButtonItem)
        
    }

    @IBAction func addItemTapped(_ sender: UIBarButtonItem) {
        // Major refactor
        requestInput(title: "New shopping list item", message: "Enter item to add to the shopping list:") { (itemName) in
            let itemCount = self.items.count
            let item = Item(name: itemName)
            self.list.add(item)
            DispatchQueue.main.async {
                self.tableView.insertRows(at: [IndexPath(row: itemCount, section: 0)], with: .top)
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        
        }    
    }


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        list.swapItem(fromIndexPath.row, to.row)
    }
    

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.toggleCheckItem(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }


}
