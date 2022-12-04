//
//  NotesViewController.swift
//  BreakingBadApp
//
//  Created by Emre Tekin on 2.12.2022.
//

import UIKit
import CoreData



class NotesViewController: BaseViewController{

    
    
    @IBOutlet weak var noteTableView: UITableView!
    
    var notes: [Note] = []
    
    
    var btn = UIButton(type: .custom)
    func floatingButton(){
        btn.frame = CGRect(x: 285, y: 600, width: 100, height: 100)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        btn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 50
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.borderWidth = 3.0
        btn.addTarget(self,action: #selector(buttonTapped), for:.touchUpInside)
        view.addSubview(btn)
    }
    
    func nonDeletedNotes() -> [Note]
    {
        var noDeleteNoteList = [Note]()
        for note in notes
        {
                noDeleteNoteList.append(note)
        }
        return noDeleteNoteList
    }
    
    
    override func viewDidLoad() {
        floatingButton()
        noteTableView.delegate = self
        noteTableView.dataSource = self
        notes = CoreDataManager.shared.getNotes()
    }
    
    @objc func buttonTapped(_ sender:Any){
        performSegue(withIdentifier: "toScreen", sender: nil)
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NotesTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(model: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            CoreDataManager.shared.deleteNote(note: note)
            notes.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toEditScreen", sender: self)
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if(segue.identifier == "toEditScreen")
            {
                let indexPath = noteTableView.indexPathForSelectedRow!
                
                let notesDetail = segue.destination as? NotesDetailViewController
                
                let selectedNote : Note!
                selectedNote = nonDeletedNotes()[indexPath.row]
                notesDetail!.selectedNote = selectedNote
                
                noteTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    

    }
