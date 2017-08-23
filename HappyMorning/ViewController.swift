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

class ViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var quoteTextField: UITextView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var facebookOval: UIButton!
    @IBOutlet weak var twitterOval: UIButton!
    
    // MARK: Properties
    var facebookChecked: Bool!
    var twitterChecked: Bool!
    var emptyOval: UIImage!
    var checkedOval: UIImage!
    
    var quotes = QuotesAPI.shared
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set default properties to initialize
        quoteTextField.delegate = self
        facebookChecked = false
        twitterChecked = false
        
        // default cusomtizations for initial view
        emptyOval = UIImage(named: "empty-oval")
        checkedOval = UIImage(named: "check-mark")
    
        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // add any customizations
        postButton.layer.cornerRadius = 20.0
        textFieldView.layer.cornerRadius = 20.0
        textFieldView.layer.borderWidth = 0.5
        textFieldView.clipsToBounds = true
        
        // illusion of placeholder text
        quoteTextField.text = "Type your quote here 👇"
        quoteTextField.textColor = UIColor.lightGray
        quoteTextField.textAlignment = .center
    }
    
    // MARK: Actions

    // toggles facebook check box icon
    @IBAction func socialMediaSelected(_ sender: UIButton) {
        if facebookChecked {
            facebookOval.setBackgroundImage(emptyOval, for: .normal)
            facebookChecked = false
        } else {
            facebookOval.setBackgroundImage(checkedOval, for: .normal)
            facebookChecked = true
        }
    }
    
    // toggles twitter check box icon
    @IBAction func socialMediaTwitterSelected(_ sender: UIButton) {
        if twitterChecked {
            twitterOval.setBackgroundImage(emptyOval, for: .normal)
            twitterChecked = false
        } else {
            twitterOval.setBackgroundImage(checkedOval, for: .normal)
            twitterChecked = true
        }
    }
    
    // renders to default view and adds new quote to the model
    @IBAction func postButton(_ sender: UIButton) {
        
        // switch to default cusomtizations for initial view
        let resetImage = UIImage(named: "empty-oval")
        facebookOval.setBackgroundImage(resetImage, for: .normal)
        twitterOval.setBackgroundImage(resetImage, for: .normal)
        
        // configure text only entered by user
        if quoteTextField.textColor == UIColor.black {
            
            // add quote to shared data model
            if let newQuote = quoteTextField.text {
                quotes.addQuote(newQuote)
            }
            
            // replaces textfield with placeholder
            quoteTextField.text = "Type your quote here 👇"
            quoteTextField.textColor = UIColor.lightGray
            quoteTextField.textAlignment = .center
            
            // USE APIs
        
        }

        // switch to default cusomtizations for initial view
        facebookChecked = false
        twitterChecked = false
    }
    
    // changes text color when user begins editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
             quoteTextField.textAlignment = .left
        }
    }
    
    // dismiss keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
