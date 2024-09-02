import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Query(sort:[
        SortDescriptor(\Expense.date, order: .reverse)
    ], animation: .snappy) private var allExpenses: [Expense]
    
    @State private var groupedExpenses: [GroupedExpense] = []
    @State private var addExpense: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedExpenses){ group in
                    Section(group.groupTitle) {
                        ForEach(group.expenses){ expense in
                            
                            ExpenseCardView(expense: expense)
                        }
                    }
                }
            }
            .navigationTitle("Expenses")
            .overlay {
                if allExpenses.isEmpty || groupedExpenses.isEmpty {
                    ContentUnavailableView {
                        Label("No Expense", systemImage: "tray.fill")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addExpense.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .onChange(of: allExpenses) { oldValue, newValue in
                if groupedExpenses.isEmpty {
                    createGroupedExpenses(newValue)
                }
            }
            
            .sheet(isPresented: $addExpense){
                AddExpenseView()
            }
        }
    }

    func createGroupedExpenses(_ expenses: [Expense]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: expenses) { expense in
                let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: expense.date)
                return dateComponents
            }
            let sortedDict = groupedDict.sorted {
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? Date()
                let date2 = calendar.date(from: $1.key) ?? Date()
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            await MainActor.run {
                groupedExpenses = sortedDict.compactMap { dict in
                    let date = Calendar.current.date(from: dict.key) ?? Date()
                    return GroupedExpense(date: date, expenses: dict.value)
                }
            }
        }
    }
}

#Preview {
    ExpenseView()
}

