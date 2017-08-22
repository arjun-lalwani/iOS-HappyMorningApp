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
    
    
    // MARK: Properties
    var userDefaults: UserDefaults!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // contents of the table are reset before view appears as model data may be mutated
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewController
    
    // returns number of rows that can be selected
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuotesAPI.shared.getAllQuotes().count
    }
    
    // returns each table view cell filled with data from model
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // deqeue reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "quotesCell", for: indexPath)
        
        // get quote from model to fill cell with appropriate data
        let quote: Quote = QuotesAPI.shared.getAllQuotes()[indexPath.row]
        cell.textLabel?.text = quote.getQuote()
        return cell
    }
}
