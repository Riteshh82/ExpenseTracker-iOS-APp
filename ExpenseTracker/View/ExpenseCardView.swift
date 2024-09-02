//
//  ExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Ritesh Yadav on 02/09/24.
//

import SwiftUI

struct ExpenseCardView: View {
    @Binding var expense: Expense
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text (expense.title)
                Text (expense.subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
                .lineLimit(1)
                Spacer (minLength: 5)
            
                Text (expense.currencyString)
                .font(.title3.bold())
        }
    }
}

