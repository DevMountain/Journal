//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Daniel Dickey on 4/19/21.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Prperties
    var entry: Entry?
    
    // MARK: - Actions
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        titleTextField.text = ""
        bodyTextField.text = ""
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let entry = entry  {
            
        print("To be implimented tomorow")
            
        } else {
          
            guard let title = titleTextField.text,
                  let body = bodyTextField.text else {return}
            
            EntryController.shared.createEntryWith(title: title, body: body)
            
        }
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    
    }

    // MARK: - Functions
    func updateViews() {
        
        guard let entry = entry else {return}
        
        titleTextField.text = entry.title
        bodyTextField.text = entry.body
        
    }
        
    
}//End of class

