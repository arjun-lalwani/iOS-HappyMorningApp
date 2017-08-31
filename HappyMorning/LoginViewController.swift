//
//  LoginViewController.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/30/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!

    @IBOutlet weak var loginWithTwitter: UIButton!
    @IBOutlet weak var loginWithFacebook: UIButton!
    @IBOutlet weak var done: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "sunrise")!)
        loginWithTwitter.adjustsFontSizeToFitWidth = true
        loginWithFacebook.adjustsFontSizeToFitWidth = true
        loginWithTwitter.layer.cornerRadius = CGFloat(20.0)
        loginWithFacebook.layer.cornerRadius = CGFloat(20.0)
        done.layer.cornerRadius = CGFloat(20.0)
    }
    
    @IBAction func loginWithTwitterTapped(_ sender: UIButton) {
        Twitter.sharedInstance().logIn(completion: {(session, error) in
            if (session != nil) {
                print("signed in as \(String(describing: session?.userName))")
                self.loginWithTwitter.setTitle("Logged in with Twitter", for: .normal)
            }
        })
    }

    @IBAction func loginWithFacebookTapped(_ sender: UIButton) {
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        if Twitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainVC") as UIViewController
            present(vc, animated: true, completion: nil)
        } else {
            let alert = Alerts.addSocialMedia()
            self.present(alert, animated: true, completion: nil)
        }
    }
}
