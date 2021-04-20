//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Daniel Dickey on 4/19/21.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    // MARK: - Properties
    
    var journal: Journal?
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return journal?.entries.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        guard let entry = journal?.entries[indexPath.row] else {return cell}
        
        cell.textLabel?.text = entry.title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
             guard let journal = journal else {return}
          
             let entryToRemove = journal.entries[indexPath.row]
            
            EntryController.deleteEntry(entryToRemove: entryToRemove , journal: journal)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
    
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let journal = journal else {return}
       
        if segue.identifier == "showEntry" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? EntryDetailViewController else {return}
            
            let entryToSend = journal.entries[indexPath.row]
            let journalToSend = journal
            
            destinationVC.entry = entryToSend
            destinationVC.journal = journalToSend
        } else if segue.identifier == "createNewEntry" {
            
            guard let destinationVC = segue.destination as? EntryDetailViewController else {return}
            
            let journalToSend = journal
            
            destinationVC.journal = journalToSend
            
        }
        
    }

}//End of class
