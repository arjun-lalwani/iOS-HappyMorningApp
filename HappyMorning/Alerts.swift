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
        let alert = UIAlertController(title: "Twitter Login Failed", message: "Could not authorize account successfully to twitter", preferredStyle: .alert)
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
    
    static func addSocialMedia() -> UIAlertController {
        let alert = UIAlertController(title: "Log in required", message: "You need to login to at least one social media account to proceed", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
}
