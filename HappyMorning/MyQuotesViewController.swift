//
//  MyQuotesViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/17/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit

class MyQuotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    private var quotes: QuotesAPI!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        quotes = QuotesAPI.shared
        
        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
        
        // customize bar button item
        let font = UIFont(name: "Avenir Next", size: 16)!
        clearButton.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // contents of the table are reset before view appears as model data may be mutated
        self.tableView.reloadData()
    }
    
    
    // MARK: Actions
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        // clears model
        quotes.deleteAllQuotes()
        
        // updates view dynamically
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewController
    
    // returns number of rows that can be selected
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfQuotes = quotes.getAllQuotes() {
            return numberOfQuotes.count
        }
        return 0
    }
    
    // returns each table view cell filled with data from model
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // deqeue reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "quotesCell", for: indexPath)
        
        // disables selection of cell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        // get quote from user defaults to fill cell with appropriate data
        if let quote: [String] = quotes.getAllQuotes() {
            cell.textLabel?.text = quote[indexPath.row]
        }
        
        return cell
    }
    
    // adds delete functionality for table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // updates model
            quotes.deleteQuote(at: indexPath.row)
            
            // updates view dynamically
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
