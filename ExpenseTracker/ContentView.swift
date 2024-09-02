//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ritesh Yadav on 24/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab:String = "Expense"
    var body: some View {
        TabView(selection:$currentTab){
            ExpenseView()
                .tag("Expense")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text ("Expenses")
                }
            
            CategoryView()
                .tag("Categories")
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text ("Categories")
                }
        }
    }
}

#Preview {
    ContentView()
}
