//
//  ViewController.swift
//  ToDoList
//
//  Created by Bartek on 3/31/20.
//  Copyright © 2020 Bartek. All rights reserved.

//MARK: - The Delegate is this current class

import UIKit

class TodoListViewController: UITableViewController  {

    var itemArray = ["Find Bag of cereal", "Buy Eggs", "Hubert"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    //MARK: - TableView Datasource Methods
    //This creates a cell to be used "Dequeueing"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //The textLabel is inside every single cell we just making it == the name of item
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell: \(itemArray[indexPath.row])")
        
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
               
        tableView.deselectRow(at: indexPath, animated: true)//lets the selected row dissapear after being selected
        
        
    }
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // need text field to be able to access the entire IBAction
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks item button on UIAlert
            
            self.itemArray.append(textField.text!)
            //need to reload data otherwise it will not show up in the array 
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
