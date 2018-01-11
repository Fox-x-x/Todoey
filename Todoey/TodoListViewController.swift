//
//  ViewController.swift
//  Todoey
//
//  Created by Pavel Yurkov on 10/01/2018.
//  Copyright © 2018 Pavel Yurkov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var ItemArray = ["Find Mike", "Buy eggos", "Destory Demogorgon", "Fuck the duck"]
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            ItemArray = items
        }
        
    }
    
    
    
    //MARK - tableView datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = ItemArray[indexPath.row]
        
        return cell
        
    }
    
    
    //MARK - tableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(ItemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       
        
    }
    
    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            //what will happen once the user clicks the "add item" button on our UIAlert
            print("success!")
            
            self.ItemArray.append(textField.text!)
            self.defaults.set(self.ItemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) {
            (cancel) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    


}

