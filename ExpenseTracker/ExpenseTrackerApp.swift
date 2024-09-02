//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Ritesh Yadav on 24/08/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:[Expense.self, Category.self])
    }
}
