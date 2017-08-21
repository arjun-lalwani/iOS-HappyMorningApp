//
//  MyQuotesViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/17/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit

class MyQuotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // turns off default alpha value set by navigation controller on navigation bar
        // this allows AppDelegate customaizations to remain intact
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quotesCell", for: indexPath)
        
        var quotes = AllQuotes()
        print(quotes.getAllQuotes())
        print(indexPath.row)
//        let quote : Quote = quotes.getAllQuotes()[indexPath.row]
        cell.textLabel?.text = "h"
    
        return cell
    }
}
