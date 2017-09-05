//
//  User.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 9/1/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import Foundation
import TwitterKit
import FBSDKLoginKit
import FacebookLogin

class User {
    
    static func isLoggedIntoFacebook() -> Bool{
      return FBSDKAccessToken.current() != nil
    }
    
    static func isLoggedIntoTwitter() -> Bool {
        return Twitter.sharedInstance().sessionStore.hasLoggedInUsers()
    }
    
    static func getTwitterUserId() -> String? {
        return Twitter.sharedInstance().sessionStore.session()?.userID
    }
    
    static func logOutOfTwitter(_ userId: String) {
        Twitter.sharedInstance().sessionStore.logOutUserID(userId)
    }
    
    static func logIntoTwitter(completion: @escaping (Bool) -> ()) {
        Twitter.sharedInstance().logIn(completion: {(session, error) in
            if (session != nil) {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    static func logOutOfFacebook() {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    static func logIntoFacebook(viewFrom: UIViewController, completion: @escaping (Bool) -> ()) {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        
        login.logIn(withPublishPermissions: ["publish_actions"], from: viewFrom) { (result, error) in
            if let cancelled = result?.isCancelled {
                if cancelled || error != nil{
                    completion(false)
                } else {
                    completion(true)
                }
            }
        } 
    }
}

final class PreferredName {
    private var preferredName: String?
    
    func setPreferredName(_ name: String) {
        preferredName = name
    }
    
    func getPreferredName() -> String? {
        return preferredName
    }
    
    static let shared = PreferredName()
}

