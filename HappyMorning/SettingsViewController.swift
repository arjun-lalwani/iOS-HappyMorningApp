//
//  SettingsViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/30/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit
import TwitterKit
import FBSDKLoginKit
import FacebookLogin

class SettingsViewController: UIViewController {

    @IBOutlet weak var twitterLoginStatusButton: UIButton!
    @IBOutlet weak var facebookLoginStatusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
        
        twitterLoginStatusButton.layer.cornerRadius = CGFloat(20.0)
        facebookLoginStatusButton.layer.cornerRadius = CGFloat(20.0)
        
        setTitlesForSocialMediaButtons()
    }

    // If user logged into Twitter, log out option available
    // If user logged out of Twitter, log into option available
    @IBAction func twitterButtonTapped(_ sender: UIButton) {
        if let userId = User.getTwitterUserId() {
            User.logOutOfTwitter(userId)
            self.present(Alerts.logOutOfTwitter(), animated: true, completion: nil)
            twitterLoginStatusButton.setTitle("Log in with Twitter", for: .normal)
        } else {
            User.logIntoTwitter() {(success) -> Void in
                if success {
                   self.twitterLoginStatusButton.setTitle("Log out of Twitter", for: .normal)
                } else {
                    self.present(Alerts.invalidTwitterLogin(), animated: true, completion: nil)
                }
            }
        }
    }
    
    // If user logged into Facebook, log out option available
    // If user logged out of Facebook, log into option available
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        if User.isLoggedIntoFacebook() {
            User.logOutOfFacebook()
            self.present(Alerts.logOutOfFacebook(), animated: true, completion: nil)
            facebookLoginStatusButton.setTitle("Log in with Facebook", for: .normal)
        } else {
            User.logIntoFacebook(viewFrom: self) {(success) -> Void in
                if success {
                    self.facebookLoginStatusButton.setTitle("Log in with Facebook", for: .normal)
                } else {
                    self.present(Alerts.invalidFacebookLogin(), animated: true, completion: nil)
                }
            }
        }
    }
    
    // customize titles based on user logged in
    private func setTitlesForSocialMediaButtons() {
        if User.isLoggedIntoTwitter() {
            twitterLoginStatusButton.setTitle("Log out of Twitter", for: .normal)
        } else {
            twitterLoginStatusButton.setTitle("Log in with Twitter", for: .normal)
        }
        
        if User.isLoggedIntoFacebook() {
            facebookLoginStatusButton.setTitle("Log out of Facebook", for: .normal)
        } else {
            facebookLoginStatusButton.setTitle("Log in with Facebook", for: .normal)
        }
    }
}
