//
//  NotesTableViewCell.swift
//  BreakingBadApp
//
//  Created by Emre Tekin on 2.12.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    func configureCell(model:Note){
        seasonLabel.text = " S: " + model.season! + " E: " + model.episode!
        //episodeLabel.text = "E: " + model.episode!
        noteLabel.text = model.note
    }
}
