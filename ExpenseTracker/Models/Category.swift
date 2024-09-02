//
//  Category.swift
//  ExpenseTracker
//
//  Created by Ritesh Yadav on 24/08/24.
//

import SwiftUI
import SwiftData

@Model

class Category {
    var categoryName: String
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.category)
    var expenses:[Expense]?
    
    init(categoryName: String) {
        self.categoryName = categoryName
        
    }
}
