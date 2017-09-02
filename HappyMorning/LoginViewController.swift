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

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var loginWithTwitter: UIButton!
    @IBOutlet weak var loginWithFacebook: UIButton!
    @IBOutlet weak var done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "sunrise")!)
        loginWithTwitter.layer.cornerRadius = CGFloat(20.0)
        loginWithFacebook.layer.cornerRadius = CGFloat(20.0)
        done.layer.cornerRadius = CGFloat(20.0)
    }
    
    @IBAction func loginWithTwitterTapped(_ sender: UIButton) {
        User.logIntoTwitter() {(success) -> Void in
            if success {
                self.loginWithTwitter.setTitle("Logged in with Twitter", for: .normal)
            } else {
                self.present(Alerts.invalidTwitterLogin(), animated: true, completion: nil)
            }
        }
    }

    @IBAction func loginWithFacebookTapped(_ sender: UIButton) {
        User.logIntoFacebook(viewFrom: self) {(success) -> Void in
            if success {
                self.loginWithFacebook.setTitle("Logged in with Facebook", for: .normal)
            } else {
                self.present(Alerts.invalidFacebookLogin(), animated: true, completion: nil)
            }
        }
    }

    @IBAction func doneTapped(_ sender: UIButton) {
        if User.isLoggedIntoFacebook() || User.isLoggedIntoTwitter() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainVC") as UIViewController
            present(vc, animated: true, completion: nil)
        } else {
            self.present(Alerts.addSocialMedia(), animated: true, completion: nil)
        }
    }
}
