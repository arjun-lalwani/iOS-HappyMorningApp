//
//  QuotesModel.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/17/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import Foundation

// Model
class AllQuotes {
    var quotes: [Quote]
    
    init() {
        quotes = []
    }
    
    func addNewQuote(newQuote: Quote) {
        quotes.append(newQuote)
    }
    
    func getAllQuotes() -> [Quote] {
        return quotes
    }
}

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
