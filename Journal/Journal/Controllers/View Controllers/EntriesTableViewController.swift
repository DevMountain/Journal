//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Daniel Dickey on 4/19/21.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        EntryController.shared.loadFromPersistenceStore()
        
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return EntryController.shared.entries.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            
            EntryController.shared.deleteEntry(entryToBeDeleted: entryToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toEntryDetails" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
            
            let destinationVC = segue.destination as? EntryDetailViewController else {return}
            
            let entryToSend = EntryController.shared.entries[indexPath.row]
            
            destinationVC.entry = entryToSend
        }
        
    }

}//End of class
