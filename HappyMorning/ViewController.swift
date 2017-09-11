//
//  ViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/13/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit
import TwitterKit
import FacebookShare
import FBSDKShareKit
import FacebookCore

class ViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var quoteTextField: UITextView!
    @IBOutlet weak var textFieldView: UIView! {
        didSet {
            textFieldView.layer.cornerRadius = 20.0
            textFieldView.layer.borderWidth = 0.5
            textFieldView.clipsToBounds = true
        }
    }
    @IBOutlet weak var postButton: UIButton! {
        didSet {
            postButton.layer.cornerRadius = 20.0
            postButton.setTitle("SAVE", for: .normal)
        }
    }
    @IBOutlet weak var facebookOval: UIButton!
    @IBOutlet weak var twitterOval: UIButton!
    @IBOutlet weak var happyMorningLabel: UILabel!
    
    // MARK: Properties 
    
    // default initializing properties
    private var socialMedia = (fbSelected: false, twitterSelected: false)
    private var ovals = (empty: UIImage(named: "empty-oval"), checked: UIImage(named: "check-mark"))
    
    // private instance of model
    private var quotes = QuotesAPI.shared
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteTextField.delegate = self
    
        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
    
        setDoneOnKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        happyMorningLabel.text = "Happy Morning,\n\(PreferredName.shared.getPreferredName()!)"
        configurePostButton()
        
        // set placeholder text if text Field is blank
        if (quoteTextField.textColor != UIColor.twitterBlue && quoteTextField.textColor != UIColor.black) {
            customizeTextView()
        }
    }
    
    // MARK: Actions

    // toggles facebook check box icon on selection
    @IBAction func socialMediaSelected(_ sender: UIButton) {
        if socialMedia.fbSelected {
            facebookOval.setBackgroundImage(ovals.empty, for: .normal)
            socialMedia.fbSelected = false
        } else {
            facebookOval.setBackgroundImage(ovals.checked, for: .normal)
            socialMedia.fbSelected = true
        }
        configurePostButton()
    }
    
    // toggles twitter check box icon on selection
    @IBAction func socialMediaTwitterSelected(_ sender: UIButton) {
        if socialMedia.twitterSelected {
            twitterOval.setBackgroundImage(ovals.empty, for: .normal)
            socialMedia.twitterSelected = false
        }  else {
            twitterOval.setBackgroundImage(ovals.checked, for: .normal)
            socialMedia.twitterSelected = true
        }
        configurePostButton()
    }
    
    // posts quote in text field to requested social media services and reloads screen to default customizations
    @IBAction func postButton(_ sender: UIButton) {
        
        // switch to default cusomtizations for initial view
        facebookOval.setBackgroundImage(ovals.empty, for: .normal)
        twitterOval.setBackgroundImage(ovals.empty, for: .normal)
        
        // configure text only entered by user
        if quoteTextField.textColor == UIColor.black || quoteTextField.textColor == UIColor.twitterBlue {
            
            if let newQuote = quoteTextField.text {
                quotes.addQuote(newQuote)
                quotes.postInUserSelectedSocialMedia(newQuote, currentVC: self, postOnTwitter: socialMedia.twitterSelected, postOnFacebook: socialMedia.fbSelected)
            }
            
            // add placeholder text
            customizeTextView()
        }
        
        socialMedia = (false, false)
    }
    
    // MARK: Text View Customizations 
    
    // changes text color when user begins editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.twitterBlue
            textView.textAlignment = .left
        }
        self.animateTextField(textView: quoteTextField, up:true)
    }
    
    // shifts frame down after dismissing keyboard
    func textViewDidEndEditing(_ textView: UITextView) {
        self.animateTextField(textView: quoteTextField, up:false)
    }
    
    // configures text color to indicate twitter post status
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count > 140 {
            textView.textColor = UIColor.black
        } else {
            textView.textColor = UIColor.twitterBlue
        }
    }
    
    // shifts super views frame up or down as keyboard appears
    func animateTextField(textView: UITextView, up: Bool) {
        let movementDistance: CGFloat = -130
        let movementDuration: Double = 0.3
        
        var movement: CGFloat = 0
        if up {
            movement = movementDistance
        } else {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    // adds toolbar with done option to keyboard
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIInputViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.quoteTextField.inputAccessoryView = keyboardToolbar
    }
    
    func dismissKeyboard() {
        self.quoteTextField.resignFirstResponder()
    }

    // MARK: Private functions
    
    // sets text to default, giving an illusion of a placeholder text
    private func customizeTextView() {
        quoteTextField.text = "Type your quote here 👇"
        quoteTextField.textColor = UIColor.lightGray
        quoteTextField.textAlignment = .center
    }
    
    private func configurePostButton() {
        if socialMedia.fbSelected || socialMedia.twitterSelected {
            postButton.setTitle("POST", for: .normal)
        } else {
            postButton.setTitle("SAVE", for: .normal)
        }
    }
}

// adds custom twitter blue color
extension UIColor {
    public class var twitterBlue: UIColor {
        return UIColor(red: 0/255, green: 172/255, blue: 237/255, alpha: 1.0)
    }
}
