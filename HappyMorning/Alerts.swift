//
//  Alerts.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/30/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import Foundation
import UIKit

struct Alerts {
    
    static func invalidTwitterLogin() -> UIAlertController {
        let alert = UIAlertController(title: "Twitter Login Failed", message: "Could not authorize your account successfully to twitter", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func invalidFacebookLogin() -> UIAlertController {
        let alert = UIAlertController(title: "Facebook Login Failed", message: "Could not authorize your account successfully to Facebook", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func logOutOfTwitter() -> UIAlertController {
        let alert = UIAlertController(title: "Log out complete", message: "You've been successfully logged out of twitter", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
   
    static func logOutOfFacebook() -> UIAlertController {
        let alert = UIAlertController(title: "Log out complete", message: "You've been successfully logged out of facebook", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func addSocialMedia() -> UIAlertController {
        let alert = UIAlertController(title: "Log in required", message: "You need to login to at least one social media account to proceed", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func twitterCharacterCountExceeded() -> UIAlertController {
        let alert = UIAlertController(title: "Cannot post to Twitter", message: "You've exceeded the character count to post on twitter", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func notLoggedIntoFacebook() -> UIAlertController {
        let alert = UIAlertController(title: "Facebook login required", message: "You're not logged into facebook. You can do so from the settings screen", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func notLoggedIntoTwitter() -> UIAlertController {
        let alert = UIAlertController(title: "Twitter login required", message: "You're not logged into twitter. You can do so from the settings screen", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func unableToPostToFacebook() -> UIAlertController {
        let alert = UIAlertController(title: "Cannot post to Facebook", message: "The post couldn't go through this time. Please check your connection", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    static func unableToPostToTwitter() -> UIAlertController {
        let alert = UIAlertController(title: "Cannot post to Twitter", message: "The tweet couldn't go through this time. Please check your connection.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
}
