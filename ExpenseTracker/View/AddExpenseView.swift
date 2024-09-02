import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var subTitle: String = ""
    @State private var date: Date = Date()
    @State private var amount: CGFloat = 0
    @State private var category: Category?
    @Query(animation: .snappy) private var allCategories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Food", text: $title)
                }
                Section("Description") {
                    TextField("Pizza Party", text: $subTitle)
                }
                
                Section("Amount") {
                    HStack(spacing: 4) {
                        Text("Rs.")
                            .fontWeight(.semibold)
                        TextField("0.0", value: $amount, formatter: formatter)
                            .keyboardType(.numberPad)
                        
                    }
                }
                
                Section("Date") {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                
                if !allCategories.isEmpty {
                    Section("Category") {
                        HStack {
                            Text("Category")
                            Spacer()
                            Picker("", selection: $category) {
                                ForEach(allCategories) { category in
                                    Text(category.categoryName)
                                        .tag(category as Category?)
                                }
                            }
                            .pickerStyle(.menu)
                            .labelsHidden()
                        }
                    }
                }
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", action: addExpense)
                        .disabled(isAddButtonDisabled)
                }
            }
        }
    }
        
        var isAddButtonDisabled: Bool {
            return title.isEmpty || subTitle.isEmpty || amount == .zero
        }
    
    
    func addExpense() {
        
       let expense = Expense(title: title, subTitle: subTitle, ammount: amount, date: date,
       category: category)
        context.insert(expense)
        dismiss()
    }
    var formatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }
    
}

#Preview {
    ContentView()
}
