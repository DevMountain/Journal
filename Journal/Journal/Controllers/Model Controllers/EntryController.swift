//
//  File.swift
//  Journal
//
//  Created by Daniel Dickey on 4/19/21.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    // MARK: - Functions
    
    func createEntryWith(title: String, body: String) {
        
        let newEntry = Entry(title: title, body: body, timeStamp: Date())
        
        entries.append(newEntry)
        
        saveToPersistenceStore()
    }
    
    func deleteEntry(entryToBeDeleted: Entry) {
        
        guard let index = entries.firstIndex(of: entryToBeDeleted) else {return}
        
        entries.remove(at: index)
        
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    
    private func fileURL() -> URL {
     let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
     return documentsDirectoryURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
 
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}//End of class
