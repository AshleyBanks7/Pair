//
//  PersonDetailViewController.swift
//  Pair
//
//  Created by Maxwell Poffenbarger on 2/14/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var personNameTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let personName = personNameTextField.text else {return}
        
        PersonController.sharedInstance.createPerson(name: personName)
        
        navigationController?.popViewController(animated: true)
        
    }
}//End of class
