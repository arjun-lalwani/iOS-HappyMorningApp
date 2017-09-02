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

// final - causes compile time error if anyone tries to subclass from QuotesAPI or override it.
final class QuotesAPI {
    
    // only 1 instance of the class is ever created and can be accessed from anywhere.
    static let shared = QuotesAPI()

    // adds quote to local storage
    func addQuote(_ quote: String) {
        if var allQuotes = UserDefaults.standard.stringArray(forKey: "allQuotes") {
            allQuotes.append(quote)
            UserDefaults.standard.set(allQuotes, forKey: "allQuotes")
        } else {
            UserDefaults.standard.set([quote], forKey: "allQuotes")
        }
    }
    
    // deletes quote from local storage
    func deleteQuote(at index: Int) {
        if var allQuotes = UserDefaults.standard.stringArray(forKey: "allQuotes") {
            allQuotes.remove(at: index)
            UserDefaults.standard.set(allQuotes, forKey: "allQuotes")
        }
    }

    // returns all quotes from local storage, if no quotes found, returns nil
    func getAllQuotes() -> [String]? {
        if let quotes = UserDefaults.standard.stringArray(forKey: "allQuotes") {
            return quotes
        }
        return nil
    }
    
    // clears all quotes in local storage
    func deleteAllQuotes() {
        UserDefaults.standard.removeObject(forKey: "allQuotes")
    }
    
    func postInUserSelectedSocialMedia(_ quote: String, currentVC: UIViewController, postOnTwitter: Bool, postOnFacebook: Bool)  {
        if quote.characters.count > 140 {
            currentVC.present(Alerts.twitterCharacterCountExceeded(), animated: true, completion: nil)
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
                        vc.present(Alerts.unableToPostToFacebook(), animated: true, completion: nil)
                    } else if connection == nil {
                        vc.present(Alerts.unableToPostToFacebook(), animated: true, completion: nil)
                    }
                })
            }
        } else {
            vc.present(Alerts.notLoggedIntoFacebook(), animated: true, completion: nil)
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
                        vc.present(Alerts.unableToPostToTwitter(), animated: true, completion: nil)
                    }
                }
            }
        } else {
            vc.present(Alerts.notLoggedIntoTwitter(), animated: true, completion: nil)
        }
    }
}
