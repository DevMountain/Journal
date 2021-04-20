//
//  File.swift
//  Journal
//
//  Created by Daniel Dickey on 4/20/21.
//

import Foundation

class JournalController {
    
    // MARK: - Properties
    static let shared = JournalController()
    var journals: [Journal] = []
    
    // MARK: - Functions
    
    func createJournalWithTitle(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        
       saveToPersistenceStore()
    }
    
    func deleteJournal(journalToDelete: Journal) {
        
        guard let index = journals.firstIndex(of: journalToDelete) else {return}
        journals.remove(at: index)
        
        saveToPersistenceStore()
        
    }
    
    func addEntryTo(entryToAdd: Entry, journal: Journal) {
        
        journal.entries.append(entryToAdd)
        
       saveToPersistenceStore()
    }
    
    func removeEntry(journal: Journal, entryToRemove: Entry) {
        
        guard let index = journal.entries.firstIndex(of: entryToRemove) else {return}
        
        journal.entries.remove(at: index)
        
        saveToPersistenceStore()
        
    }
    // MARK: - Persistence
    
    private func fileURL() -> URL {
     let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentsDirectoryURL = urls[0].appendingPathComponent("Journals.json")
     return documentsDirectoryURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
 
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    
}//End of class
