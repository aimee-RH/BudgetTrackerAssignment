//
//  ContentView.swift
//  BudgetTracker
//
//  Created by Rik Roy on 8/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = BudgetViewModel()
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    // MARK: - Budget Header
                    Text("Budget Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // TODO: Show remaining budget here
                    // Note: Budget can change color in certain cases
                    Text(String(format: "Remaining: $%.2f", viewModel.remainingBudget))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(viewModel.budgetColor)

                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                // MARK: - Add Expense Form
                VStack(spacing: 15) {

                    // TODO: TextField for expense name
                    TextField("Expense Name", text: $expenseName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    // TODO: TextField for expense amount
                    TextField("Amount", text: $expenseAmount)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .keyboardType(.decimalPad)

                    Button {
                        // TODO: Add expense and remember to clear the fields
                        if let amount = Double(expenseAmount), !expenseName.isEmpty {
                            viewModel.addExpense(name: expenseName, amount: amount)
                            expenseName = ""
                            expenseAmount = ""
                        }
                    } label: {
                        Text("Add Expense")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                            )
                            .foregroundStyle(.white)
                        
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                // MARK: - Expenses List
                VStack(alignment: .leading, spacing: 10) {
                    Text("Expenses")
                        .font(.headline)

                    // TODO: If there are no expenses, show "No expenses yet"
                    if viewModel.expenses.isEmpty {
                        Text("No expenses yet")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    }

                    ForEach($viewModel.expenses) { $expense in
                        // TODO: Wrap each expense in a NavigationLink
                        // Destination should be ExpenseDetailView(expense: $expense, viewModel: viewModel)
                        NavigationLink(destination: ExpenseDetailView(expense: $expense, viewModel: viewModel)) {
                            // Inside the row, display:
                            // - Expense name
                            // - Expense amount
                            // - A delete button
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(expense.name)
                                        .font(.headline)
                                    Text(String(format: "$%.2f", expense.amount))
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Button {
                                    viewModel.removeExpense(expense: expense)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                Spacer()
            }
            .padding()
        }
        .padding()
        .navigationTitle("Budget Tracker")
    }
}

#Preview {
    ContentView()
}
