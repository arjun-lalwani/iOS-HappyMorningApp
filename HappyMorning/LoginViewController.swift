//
//  LoginViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/30/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit
import TwitterKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var loginWithTwitter: UIButton!
    @IBOutlet weak var loginWithFacebook: UIButton!
    @IBOutlet weak var done: UIButton!
    
    // MARK: Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adds custom UI
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "sunrise")!)
        loginWithTwitter.layer.cornerRadius = CGFloat(20.0)
        loginWithFacebook.layer.cornerRadius = CGFloat(20.0)
        done.layer.cornerRadius = CGFloat(20.0)
    }
    
    // MARK: Actions
    
    // sends request to login user with twitter
    @IBAction func loginWithTwitterTapped(_ sender: UIButton) {
        User.logIntoTwitter() {(success) -> Void in
            if success {
                self.loginWithTwitter.setTitle("Logged in with Twitter", for: .normal)
            } else {
                self.present(LoginAlerts.invalidTwitterLogin(), animated: true, completion: nil)
            }
        }
    }

    // sends request to login user with facebook
    @IBAction func loginWithFacebookTapped(_ sender: UIButton) {
        User.logIntoFacebook(viewFrom: self) {(success) -> Void in
            if success {
                self.loginWithFacebook.setTitle("Logged in with Facebook", for: .normal)
            } else {
                self.present(LoginAlerts.invalidFacebookLogin(), animated: true, completion: nil)
            }
        }
    }

    // presents new screen to user, if login is successful
    @IBAction func doneTapped(_ sender: UIButton) {
        if User.isLoggedIntoFacebook() || User.isLoggedIntoTwitter() {
            let alert = UserAlerts.setPreferredName(sender: self)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.present(LoginAlerts.addSocialMedia(), animated: true, completion: nil)
        }
    }
}
