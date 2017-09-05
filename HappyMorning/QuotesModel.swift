//
//  QuotesModel.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/17/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import Foundation
import TwitterKit
import FBSDKLoginKit
import FacebookCore

final class QuotesAPI {
    
    // creates a singleton
    static let shared = QuotesAPI()
    
    private var quotesStorage = [String]()
    
    /**
        Stores quote into a list of quotes
        
        - Parameter quote: gvien quote is appended to list of quotes
     */
    func addQuote(_ quote: String) {
        quotesStorage.append(quote)
    }
    
    /** 
        Deletes quote from list of quotes
     
        - Parameter index: removes quote from requested index of cell
     */
    func deleteQuote(at index: Int) {
        quotesStorage.remove(at: index)
    }

    /**
        Returns a list of all quotes
     
        - Returns: List of all quotes stored internally
    */
    func getAllQuotes() -> [String] {
        let quoteStorageCopy = quotesStorage
        return quoteStorageCopy
    }
    
    /**
        Deletes all quotes stored internally
    */
    func deleteAllQuotes() {
        quotesStorage.removeAll()
    }
    
    /**
     
 
    */
    func postInUserSelectedSocialMedia(_ quote: String, currentVC: UIViewController, postOnTwitter: Bool, postOnFacebook: Bool)  {
        if quote.characters.count > 140 {
            currentVC.present(LoginAlerts.twitterCharacterCountExceeded(), animated: true, completion: nil)
            if postOnFacebook {
                postToFacebook(quote, vc: currentVC)
            }
        } else {
            if postOnTwitter && postOnFacebook {
                postToTwitter(quote, vc: currentVC)
                postToFacebook(quote, vc: currentVC)
            } else if postOnFacebook {
                postToFacebook(quote, vc: currentVC)
            } else if postOnTwitter {
                postToTwitter(quote, vc: currentVC)
            }
        }
    }

    // Prcoess info in background and present ALERTS APPROPRIATELY
    private func postToFacebook(_ quote: String, vc: UIViewController) {
        if User.isLoggedIntoFacebook() {
            if FBSDKAccessToken.current().hasGranted("publish_actions") {
                FBSDKGraphRequest.init(graphPath: "me/feed", parameters: ["message": quote], httpMethod: "POST").start(completionHandler: { (connection, result, error) -> Void in
                    if let error = error {
                        debugPrint("Error: \(error)")
                        vc.present(LoginAlerts.unableToPostToFacebook(), animated: true, completion: nil)
                    } else if connection == nil {
                        vc.present(LoginAlerts.unableToPostToFacebook(), animated: true, completion: nil)
                    }
                })
            }
        } else {
            vc.present(LoginAlerts.notLoggedIntoFacebook(), animated: true, completion: nil)
        }
    }
    
    private func postToTwitter(_ quote: String, vc: UIViewController) {
        if User.isLoggedIntoTwitter() {
            let store = Twitter.sharedInstance().sessionStore
            if let userid = store.session()?.userID {
                let client = TWTRAPIClient(userID: userid)
                let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/update.json"
                let params = ["status": quote]
                var clientError : NSError?
                
                let request = client.urlRequest(withMethod: "POST", url: statusesShowEndpoint, parameters: params, error: &clientError)
                client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                    if (connectionError != nil) {
                        vc.present(LoginAlerts.unableToPostToTwitter(), animated: true, completion: nil)
                    }
                }
            }
        } else {
            vc.present(LoginAlerts.notLoggedIntoTwitter(), animated: true, completion: nil)
        }
    }
}
