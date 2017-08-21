//
//  ViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/13/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit

enum socialMedia {
    case facebook
    case twitter
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var facebookOval: UIButton!
    @IBOutlet weak var twitterOval: UIButton!
    
    // MARK: Properties
    var facebookChecked: Bool!
    var twitterChecked: Bool!
    var emptyOval: UIImage!
    var checkedOval: UIImage!
    
    var quotes = AllQuotes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        quoteTextField.delegate = self
        
        // turns off default alpha value set by navigation controller on navigation bar
        // this allows AppDelegate customaizations to remain intact
        self.navigationController?.navigationBar.isTranslucent = false
        
        facebookChecked = false
        twitterChecked = false
        emptyOval = UIImage(named: "empty-oval")
        checkedOval = UIImage(named: "check-mark")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        postButton.layer.cornerRadius = 20.0
        textFieldView.layer.cornerRadius = 20.0
        textFieldView.layer.borderWidth = 0.5
        textFieldView.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func socialMediaSelected(_ sender: UIButton) {
        if facebookChecked {
            facebookOval.setBackgroundImage(emptyOval, for: .normal)
            facebookChecked = false
        } else {
            facebookOval.setBackgroundImage(checkedOval, for: .normal)
            facebookChecked = true
        }
    }
    
    @IBAction func socialMediaTwitterSelected(_ sender: UIButton) {
        if twitterChecked {
            twitterOval.setBackgroundImage(emptyOval, for: .normal)
            twitterChecked = false
        } else {
            twitterOval.setBackgroundImage(checkedOval, for: .normal)
            twitterChecked = true
        }
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        let resetImage = UIImage(named: "empty-oval")
        
        facebookOval.setBackgroundImage(resetImage, for: .normal)
        twitterOval.setBackgroundImage(resetImage, for: .normal)
        
        // manipulate data using facebook check and twitter check
        // use delegate to pass data to my VC
        if let text = quoteTextField.text {
            let newQuote = Quote(quote: text, numOfCharachers: text.characters.count)
            
            quotes.addNewQuote(newQuote: newQuote)
            print(quotes.getAllQuotes())
        }
    
        facebookChecked = false
        twitterChecked = false
    }
    
    // dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
