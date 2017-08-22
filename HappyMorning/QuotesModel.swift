//
//  QuotesModel.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/17/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import Foundation


class Quote {
    var quote: String
    var numOfCharachers: Int
    
    init(quote: String, numOfCharachers: Int) {
        self.quote = quote
        self.numOfCharachers = numOfCharachers
    }
    
    func getQuote() -> String {return self.quote}
    
    func getNumOfChar() -> Int {return self.numOfCharachers}
}


// final - causes compile time error if anyone tries to subclass from QuotesAPI or override it.
final class QuotesAPI {
    
    // only 1 instance of the class is ever created and can be accessed from anywhere.
    static let shared = QuotesAPI()

    private var quotes: [Quote]
    
    private init() {
        quotes = [Quote]()
    }
    
    func addQuote(_ quote: Quote) {
        quotes.append(quote)
    }
    
    func deleteQuote(at index: Int) {
        quotes.remove(at: index)
    }

    func getAllQuotes() -> [Quote] {
        // encapsulating original data from being mutated
        let quotes = self.quotes
        return quotes
    }
}

class UserDefaultsManager {
    
    let userDefaults = UserDefaults.standard
    
    init() {
        userDefaults.set(QuotesAPI.shared.getAllQuotes(), forKey: "allQuotes")
    }
    
    func getAllQuotes() -> [Quote] {
        return userDefaults.value(forKey: "allQuotes") as! [Quote]
    }
}


