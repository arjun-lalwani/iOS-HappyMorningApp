//
//  QuotesModel.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/17/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import Foundation
import TwitterKit

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
}
