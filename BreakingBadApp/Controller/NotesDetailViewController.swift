//
//  NotesDetailViewController.swift
//  BreakingBadApp
//
//  Created by Emre Tekin on 2.12.2022.
//

import UIKit



class NotesDetailViewController: UIViewController {
    
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var episodeTextField: UITextField!
    
    var selectedNote: Note? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(selectedNote != nil)
        {
            seasonTextField.text = selectedNote?.season
            episodeTextField.text = selectedNote?.episode
            noteTextView.text = selectedNote?.note
        }
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let save = CoreDataManager.shared.saveNote(model: CoreDataModel(season: seasonTextField.text ?? "0", episode: episodeTextField.text ?? "0", note: noteTextView.text ?? "Nil"))
        
        self.dismiss(animated: true)
    }
}
