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
    //var sections: [[Int]] = [[]]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.sharedInstance.loadFromPersistantStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        isRandom = true
        shuffle()
        tableView.reloadData()
        print("it worked")
    }
    
    //MARK: - Class Methods
    func shuffle() {
        PersonController.sharedInstance.persons.shuffle()
    }
    
    func random() {
        
        //        var randomArray: [Person] = []
        //
        //        guard let random = PersonController.sharedInstance.persons.randomElement() else {return}
        //
        //        if random == random {
        //            return
        //        }
        //
        //        randomArray.append(random)
        
        
        //        var random2DArray: [[Person]] = [[]]
        //        var randomArray: [Person] = []
        //        var randomArrayAddition = 1
        //
        //        for person in PersonController.sharedInstance.persons {
        //            var currentArray = randomArray
        //            if currentArray.count > 2 {
        //                currentArray.append(person)
        //            } else {
        //                random2DArray.append(currentArray)
        //                var newArray = "\(currentArray)\(randomArrayAddition)"
        //                randomArrayAddition += 1
        //            }
        //        }
    }
    
    //MARK: - Table view data source methods
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //
    //        if PersonController.sharedInstance.persons.count < 2 {
    //            return PersonController.sharedInstance.persons.count
    //        }
    //
    //        return PersonController.sharedInstance.persons.count / 2
    //
    //    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isRandom == true {
            return "Group \(section)"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        if PersonController.sharedInstance.persons.count > 2 {
        //
        //            return 2
        //        }
        
        return PersonController.sharedInstance.persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = PersonController.sharedInstance.persons[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let personToDelete = PersonController.sharedInstance.persons[indexPath.row]
            
            PersonController.sharedInstance.deletePerson(person: personToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}//End of class
