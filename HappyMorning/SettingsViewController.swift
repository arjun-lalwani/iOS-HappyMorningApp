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
    
    // MARK: Outlets
    @IBOutlet weak var twitterLoginStatusButton: UIButton!
    @IBOutlet weak var facebookLoginStatusButton: UIButton!
    @IBOutlet weak var changePreferredName: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // turns off default alpha value set by navigation controller on navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
        
        // adds default customization to buttons
        twitterLoginStatusButton.layer.cornerRadius = CGFloat(20.0)
        facebookLoginStatusButton.layer.cornerRadius = CGFloat(20.0)
        changePreferredName.layer.cornerRadius = CGFloat(20.0)
        
        setTitlesForSocialMediaButtons()
    }
    
    // MARK: Actions
    
    // Toggles between allowing users to log in and log out of Twitter
    @IBAction func twitterButtonTapped(_ sender: UIButton) {
        if let userId = User.getTwitterUserId() {
            User.logOutOfTwitter(userId)
            self.present(LoginAlerts.logOutOfTwitter(), animated: true, completion: nil)
            twitterLoginStatusButton.setTitle("Log in with Twitter", for: .normal)
        } else {
            User.logIntoTwitter() {[weak weakSelf = self](success) -> Void in
                if success {
                    weakSelf?.twitterLoginStatusButton.setTitle("Log out of Twitter", for: .normal)
                } else {
                    weakSelf?.present(LoginAlerts.invalidTwitterLogin(), animated: true, completion: nil)
                }
            }
        }
    }

    // Toggles between allowing users to log in and log out of Facebook
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        if User.isLoggedIntoFacebook() {
            User.logOutOfFacebook()
            self.present(LoginAlerts.logOutOfFacebook(), animated: true, completion: nil)
            facebookLoginStatusButton.setTitle("Log in with Facebook", for: .normal)
        } else {
            User.logIntoFacebook(viewFrom: self) {[weak weakSelf = self](success) -> Void in
                if success {
                    weakSelf?.facebookLoginStatusButton.setTitle("Log out of Facebook", for: .normal)
                } else {
                    weakSelf?.present(LoginAlerts.invalidFacebookLogin(), animated: true, completion: nil)
                }
            }
        }
    }
    
    // Allows user to configure preferred name
    @IBAction func changePreferredName(_ sender: UIButton) {
        let alert = UserAlerts.changePreferredName()
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Private functions
    
    // Customize titles based on user logged in
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
