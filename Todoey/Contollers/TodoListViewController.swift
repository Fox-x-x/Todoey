//
//  ViewController.swift
//  Todoey
//
//  Created by Pavel Yurkov on 10/01/2018.
//  Copyright © 2018 Pavel Yurkov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        loadItems()
        
    }
    
    
    
    //MARK - tableView datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator:
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    
    //MARK - tableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        print(self.itemArray)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            //what will happen once the user clicks the "add item" button on our UIAlert
            print("success!")
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            print(self.itemArray)
            
            self.saveItems()
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) {
            (cancel) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
                do {
                    itemArray = try decoder.decode([Item].self, from: data)
                } catch {
                    print("error decoding itemArray, \(error)")
                }
                
            }
        }
        
    }


}

