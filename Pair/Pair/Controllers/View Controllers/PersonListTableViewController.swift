//
//  PersonListTableViewController.swift
//  Pair
//
//  Created by Maxwell Poffenbarger on 2/14/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    //MARK: - Properties
    var isRandom: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    var pairs: [[Person]] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.sharedInstance.loadFromPersistantStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        random()
        tableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        isRandom = true
        random()
        tableView.reloadData()
        print("it worked")
    }
    
    //MARK: - Class Methods
    func random() {
        
        var random2DArray: [[Person]] = []
        var newArray: [Person] = []
        
        for person in PersonController.sharedInstance.persons.shuffled() {
            
            if newArray.count < 2 {
                newArray.append(person)
            } else if newArray.count == 2 {
                random2DArray.append(newArray)
                newArray = []
                newArray.append(person)
            }
        }
        
        if newArray.count > 0 {
            random2DArray.append(newArray)
        }
        
        pairs = random2DArray
    }
    
    //MARK: - Table view data source methods
        override func numberOfSections(in tableView: UITableView) -> Int {

            return pairs.count
        }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isRandom == true {
            return "Group \(section + 1)"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pairs[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = pairs[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let personToDelete = pairs[indexPath.section][indexPath.row]
            
            PersonController.sharedInstance.deletePerson(person: personToDelete)
            
            random()
            tableView.reloadData()
        }
    }
}//End of class
