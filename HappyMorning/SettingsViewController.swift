//
//  SettingsViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/30/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit
import TwitterKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var twitterLoginStatusButton: UIButton!
    @IBOutlet weak var facebookLoginStatusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
        
        if Twitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            twitterLoginStatusButton.setTitle("Log out of Twitter", for: .normal)
        } else {
            twitterLoginStatusButton.setTitle("Log in with Twitter", for: .normal)
        }
        
        twitterLoginStatusButton.layer.cornerRadius = CGFloat(20.0)
        facebookLoginStatusButton.layer.cornerRadius = CGFloat(20.0)
    }

    @IBAction func twitterButtonTapped(_ sender: UIButton) {
        
        // Log out of twitter logic
        if let userId = Twitter.sharedInstance().sessionStore.session()?.userID {
            Twitter.sharedInstance().sessionStore.logOutUserID(userId)
            self.present(Alerts.logOutOfTwitter(), animated: true, completion: nil)
            twitterLoginStatusButton.setTitle("Log in with Twitter", for: .normal)
        } else {
            Twitter.sharedInstance().logIn(completion: { (session, error) in
                if (session != nil) {
                    self.twitterLoginStatusButton.setTitle("Log out of Twitter", for: .normal)
                }
            })
        }
    }
}
