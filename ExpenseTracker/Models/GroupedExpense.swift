//
//  GroupedExpense.swift
//  ExpenseTracker
//
//  Created by Ritesh Yadav on 24/08/24.
//

import SwiftUI

struct GroupedExpense: Identifiable{
    var id: UUID = .init()
    var date: Date
    var expenses: [Expense]
    
    var groupTitle: String{
        let calendar = Calendar.current
        if calendar.isDateInToday(date){
            return "Today"
        } else if calendar.isDateInYesterday(date){
            return "Yesterday"
        } else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
}
