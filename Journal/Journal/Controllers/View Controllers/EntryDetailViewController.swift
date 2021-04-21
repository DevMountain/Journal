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

    // MARK: - Properties
    var entry: Entry?
    var journal: Journal?
    
    // MARK: - Actions
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        titleTextField.text = ""
        bodyTextField.text = ""
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextField.text, !title.isEmpty,
              let journal = journal else {return}
        
        if let entry = entry  {
            
            EntryController.update(entry: entry, newTitle: title, newBody: body)
            
        } else {
            
            EntryController.createEntryWith(title: title, body: body, journal: journal)
            
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

