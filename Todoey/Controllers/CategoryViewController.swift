//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Scott Kilbourn on 6/30/18.
//  Copyright © 2018 Scott Kilbourn. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    var realm: Realm!
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        loadCategories()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    // MARK: - Data manipulation methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new todoey category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            if (alert.textFields![0].text! != "") {
                let newCategory = Category()
                
                newCategory.name = alert.textFields![0].text!
                newCategory.dateCreated = Date()
                
                self.save(category: newCategory)
            }
            else {
                let nopeAlert = UIAlertController(title: "Unable to add a blank category", message: "", preferredStyle: .alert)
                nopeAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(nopeAlert, animated: true, completion: nil)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


