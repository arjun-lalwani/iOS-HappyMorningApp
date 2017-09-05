//
//  QuoteDetailViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 9/4/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {

    @IBOutlet weak var quote: UILabel!
    var quoteToPresent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        quote.text = quoteToPresent!
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
    
    }
    
    @IBAction func twitterButtonTapped(_ sender: UIButton) {
    
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
   
    }
}
