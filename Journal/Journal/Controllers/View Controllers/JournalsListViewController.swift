//
//  JournalsListViewController.swift
//  Journal
//
//  Created by Daniel Dickey on 4/20/21.
//

import UIKit

class JournalsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        
        JournalController.shared.loadFromPersistenceStore()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        journalListTableView.reloadData()
        
    }
    // MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
             
        newJournalCreated()
        
    }
    
    // MARK: - Functions
    
    func newJournalCreated() {
        
        guard let newJournalTitle = journalTitleTextField.text, !newJournalTitle.isEmpty else {return}
        
        JournalController.shared.createJournalWithTitle(title: newJournalTitle)
        
        journalListTableView.reloadData()
        journalTitleTextField.text = ""

    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEntryList" {
            
            guard let indexPath = journalListTableView.indexPathForSelectedRow else {return}
            guard let destinationVC = segue.destination as? EntriesTableViewController else {return}
            
            let journalToSend = JournalController.shared.journals[indexPath.row]
            
            destinationVC.journal = journalToSend
            
        }
     
    }
    
}//End of class

extension JournalsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        JournalController.shared.journals.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = journalListTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        
        return cell
        
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          
            let journalToDelete = JournalController.shared.journals[indexPath.row]
            
            JournalController.shared.deleteJournal(journalToDelete: journalToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
}
