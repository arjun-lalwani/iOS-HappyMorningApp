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
    
    // MARK: Properties
    private var quotes: QuotesAPI = QuotesAPI.shared
    private var selectedQuote: String?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
        
        // customize bar button item
        let font = UIFont(name: "Avenir Next", size: 16)!
        clearButton.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
         // contents of the model maybe updated
        self.tableView.reloadData()
    }
    
    
    // MARK: Actions
    
    // deletes all quotes internally, and dynamically updates UI
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        quotes.deleteAllQuotes()
        self.tableView.reloadData()
    }
    
    // MARK: Table View customizations
    
    // returns number of rows that can be selected
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.getAllQuotes().count
    }
    
    // returns each table view cell filled with data from model
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "quotesCell", for: indexPath)
        
        // configure cell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.text = quotes.getAllQuotes()[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuote = quotes.getAllQuotes()[indexPath.row]
        self.performSegue(withIdentifier: "quoteDetailSegue", sender: self)
    }
    
    // adds delete functionality for table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            quotes.deleteQuote(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quoteDetailSegue" {
            let quoteDetailVC = segue.destination as? QuoteDetailViewController
            quoteDetailVC?.quoteToPresent = selectedQuote!
        }
    }
}
