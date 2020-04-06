//
//  ViewController.swift
//  ToDoList
//
//  Created by Bartek on 3/31/20.
//  Copyright © 2020 Bartek. All rights reserved.

//MARK: - The Delegate is this current class
//Need core data to use Item
import UIKit
import CoreData

class TodoListViewController: UITableViewController  {
 
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sandboxing here, to the items.plist, which is where we will store our array
        print(dataFilePath)
        //loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        // Do any additional setup after loading the view.
        
    }
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //This creates a cell to be used "Dequeueing"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //The textLabel is inside every single cell we just making it == the name of item
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //terenary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell: \(itemArray[indexPath.row].title)")
        
        //this turns the item array to be the reverse of what it is so in this case the ! turns it false
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
       
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // need text field to be able to access the entire IBAction
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks item button on UIAlert
            //CRUD Create
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        
        
        do {
            
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
        //need to reload data otherwise it will not show up in the array
    }
    
//    func loadItems(){
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding data \(error)")
//            }
//        }
//    }
//
//
    
    
}

