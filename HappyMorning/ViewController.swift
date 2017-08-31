//
//  ViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/13/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var quoteTextField: UITextView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var facebookOval: UIButton!
    @IBOutlet weak var twitterOval: UIButton!
    
    // MARK: Properties 
    
    // default initializing properties
    var socialMedia = (fbSelected: false, twitterSelected: false)
    var ovals = (empty: UIImage(named: "empty-oval"), checked: UIImage(named: "check-mark"))
    
    // model is protected, so no one can create a new instance of this class and access the quotes using the '.' syntax
    private var quotes = QuotesAPI.shared
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set default properties to initialize
        quoteTextField.delegate = self
    
        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // adding customizations
        postButton.layer.cornerRadius = 20.0
        textFieldView.layer.cornerRadius = 20.0
        textFieldView.layer.borderWidth = 0.5
        textFieldView.clipsToBounds = true
        
        // illusion of placeholder text
        SetToDefault(quoteTextField)
        
        
        if (Twitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            print(Twitter.sharedInstance().sessionStore.existingUserSessions())
            print("exists")
        } else {
            print("no user exists")
        }
    }
    
    // MARK: Actions

    // toggles facebook check box icon
    @IBAction func socialMediaSelected(_ sender: UIButton) {
        if socialMedia.fbSelected {
            facebookOval.setBackgroundImage(ovals.empty, for: .normal)
            socialMedia.fbSelected = false
        } else {
            facebookOval.setBackgroundImage(ovals.checked, for: .normal)
            socialMedia.fbSelected = true
        }
    }
    
    // toggles twitter check box icon
    @IBAction func socialMediaTwitterSelected(_ sender: UIButton) {
        if socialMedia.twitterSelected {
            twitterOval.setBackgroundImage(ovals.empty, for: .normal)
            socialMedia.twitterSelected = false
        } else {
            twitterOval.setBackgroundImage(ovals.checked, for: .normal)
            socialMedia.twitterSelected = true
        }
    }
    
    // renders to default view and adds new quote to the model
    @IBAction func postButton(_ sender: UIButton) {
        
        // switch to default cusomtizations for initial view
        facebookOval.setBackgroundImage(ovals.empty, for: .normal)
        twitterOval.setBackgroundImage(ovals.empty, for: .normal)
        
        // configure text only entered by user
        if quoteTextField.textColor == UIColor.black {
            
            // add quote to shared data model
            if let newQuote = quoteTextField.text {
                quotes.addQuote(newQuote)
                postToTwitter(newQuote)
            }
            
            // replaces textfield with placeholder
            SetToDefault(quoteTextField)
        }

        // switch to default cusomtizations for initial view
        socialMedia = (false, false)
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
    
    private func SetToDefault(_ textView: UITextView) {
        textView.text = "Type your quote here 👇"
        textView.textColor = UIColor.lightGray
        textView.textAlignment = .center
    }
    
    private func postToTwitter(_ newQuote: String) {
        let composer = TWTRComposer()
        
        composer.setText(newQuote)
        composer.setImage(UIImage(named: "twitterkit"))
        
        
        composer.show(from: self.navigationController!, completion: {(result) -> Void in
            print(result)
            if (result == .done) {
                print("Successfully composed Tweet")
            } else {
                print("Cancelled composing")
            }
        })
    }
}
