//
//  QuoteViewController.swift
//  BreakingBadApp
//
//  Created by Emre Tekin on 26.11.2022.
//

import UIKit
import SwiftAlertView

final class QuoteViewController: BaseViewController {
    
    var selected: CharacterModel?
    
    
    
    @IBOutlet weak var QuoteTableView: UITableView!{
        didSet{
            QuoteTableView.delegate = self
            QuoteTableView.dataSource = self
            
        }
    }
    var quotes: [QuoteModel]?{
        didSet{
            QuoteTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        let str = selected?.name
        //let newStr = str?.replacingCharacters(in: " ", with: "+")
        let toArray = str?.components(separatedBy: " ")
        let backToString = toArray?.joined(separator: "+")
        Client.getQuotes(author:backToString ?? "", completion: { quotes, error in
           // print(quotes)
            self.quotes = quotes
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription) {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            if quotes?.isEmpty ?? true {
                self.showErrorAlert(message: "No History") {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.indicator.stopAnimating()
            
        })
    }
    
}

extension QuoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let characterQuote = quotes![indexPath.row].quote
        cell.textLabel?.text = characterQuote
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

