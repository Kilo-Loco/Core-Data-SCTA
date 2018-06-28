//
//  ViewController.swift
//  Brain Dump
//
//  Created by Kyle Lee on 6/20/18.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.dataSource = self
        loadNotes()
    }
    
    func loadNotes() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            guard let notes = fetchedObjects as? [Note] else { return }
            
            self.notes = notes
            tableView.reloadData()
            
            
        } catch {
            print(error)
        }
        
        
        
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            
            guard
                let noteBody = alert.textFields?.first?.text,
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let newNote = Note(context: context)
            newNote.body = noteBody
            
            appDelegate.saveContext()
            
            self.notes.append(newNote)
            self.tableView.reloadData()
            
        }
        
        alert.addAction(saveAction)
        
        present(alert, animated: true)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.body
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    
    
    
}













