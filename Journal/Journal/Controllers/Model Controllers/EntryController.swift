//
//  File.swift
//  Journal
//
//  Created by Daniel Dickey on 4/19/21.
//

import Foundation

class EntryController {
    
    // MARK: - Functions
    
    static func createEntryWith(title: String, body: String, journal: Journal) {
        
        let newEntry = Entry(title: title, body: body)
        
        JournalController.shared.addEntryTo(entryToAdd: newEntry, journal: journal)
        
        JournalController.shared.saveToPersistenceStore()
        
    }
    
    static func deleteEntry(entryToRemove: Entry, journal: Journal) {
        
        JournalController.shared.removeEntry(journal: journal, entryToRemove: entryToRemove)
        
        JournalController.shared.saveToPersistenceStore()
        
    }
    
    static func update(entry: Entry, newTitle: String, newBody: String) {
        
        entry.title = newTitle
        entry.body = newBody
        
        JournalController.shared.saveToPersistenceStore()
        
    }
    
}//End of class
