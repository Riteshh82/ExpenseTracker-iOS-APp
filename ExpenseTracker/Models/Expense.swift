//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Ritesh Yadav on 24/08/24.
//

import SwiftUI
import SwiftData

@Model

class Expense {
    var title: String
    var subTitle: String
    var ammount: Double
    var date: Date
    var category: Category?
    
    

    init(title: String, subTitle: String, ammount: Double, date: Date, category: Category? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.ammount = ammount
        self.date = date
        self.category = category
    }
    
    @Transient 
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(for: ammount) ?? ""
    }
}
