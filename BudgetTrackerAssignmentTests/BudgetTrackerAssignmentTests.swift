//
//  BudgetTrackerAssignmentTests.swift
//  BudgetTrackerAssignmentTests
//
//  Created by Rik Roy on 8/22/25.
//

import Testing
@testable import BudgetTrackerAssignment

struct BudgetTrackerAssignmentTests {

    @Test func testRemainingBudgetWithNoExpenses() async throws {
        // Test: Remaining budget should be 500.0 with no expenses
        let viewModel = BudgetViewModel()

        #expect(viewModel.remainingBudget == 500.0)
    }

    @Test func testRemainingBudgetWithExpenses() async throws {
        // Test: Remaining budget should decrease when expenses are added
        let viewModel = BudgetViewModel()

        viewModel.addExpense(name: "Coffee", amount: 5.50)
        #expect(viewModel.remainingBudget == 494.5)

        viewModel.addExpense(name: "Lunch", amount: 15.00)
        #expect(viewModel.remainingBudget == 479.5)
    }

    @Test func testRemainingBudgetWhenOverspent() async throws {
        // Test: Remaining budget should be negative when overspent
        let viewModel = BudgetViewModel()

        viewModel.addExpense(name: "Expensive Item", amount: 600.0)
        #expect(viewModel.remainingBudget == -100.0)
    }

    @Test func testBudgetColorWhenWithinBudget() async throws {
        // Test: Budget color should be green when within budget
        let viewModel = BudgetViewModel()

        // Default state - no expenses
        #expect(viewModel.budgetColor == .green)

        // With expenses but still within budget
        viewModel.addExpense(name: "Coffee", amount: 5.50)
        #expect(viewModel.budgetColor == .green)
    }

    @Test func testBudgetColorWhenOverspent() async throws {
        // Test: Budget color should be red when overspent
        let viewModel = BudgetViewModel()

        viewModel.addExpense(name: "Expensive Item", amount: 600.0)
        #expect(viewModel.budgetColor == .red)
    }

    @Test func testAddExpense() async throws {
        // Test: Adding expense should increase expenses array count
        let viewModel = BudgetViewModel()

        #expect(viewModel.expenses.count == 0)

        viewModel.addExpense(name: "Coffee", amount: 5.50)
        #expect(viewModel.expenses.count == 1)
        #expect(viewModel.expenses[0].name == "Coffee")
        #expect(viewModel.expenses[0].amount == 5.50)

        viewModel.addExpense(name: "Lunch", amount: 15.00)
        #expect(viewModel.expenses.count == 2)
        #expect(viewModel.expenses[1].name == "Lunch")
        #expect(viewModel.expenses[1].amount == 15.00)
    }

    @Test func testRemoveExpense() async throws {
        // Test: Removing expense should decrease expenses array count
        let viewModel = BudgetViewModel()

        viewModel.addExpense(name: "Coffee", amount: 5.50)
        viewModel.addExpense(name: "Lunch", amount: 15.00)
        viewModel.addExpense(name: "Dinner", amount: 25.00)

        #expect(viewModel.expenses.count == 3)

        let expenseToRemove = viewModel.expenses[1]
        viewModel.removeExpense(expense: expenseToRemove)

        #expect(viewModel.expenses.count == 2)
        #expect(viewModel.expenses.contains { $0.name == "Lunch" } == false)
        #expect(viewModel.expenses.contains { $0.name == "Coffee" } == true)
        #expect(viewModel.expenses.contains { $0.name == "Dinner" } == true)
    }

    @Test func testRemainingBudgetAfterRemoval() async throws {
        // Test: Remaining budget should increase after removing expense
        let viewModel = BudgetViewModel()

        viewModel.addExpense(name: "Coffee", amount: 5.50)
        viewModel.addExpense(name: "Lunch", amount: 15.00)

        #expect(viewModel.remainingBudget == 479.5)

        let expenseToRemove = viewModel.expenses[0]
        viewModel.removeExpense(expense: expenseToRemove)

        #expect(viewModel.remainingBudget == 485.0)
    }

    @Test func testMultipleExpensesSum() async throws {
        // Test: Multiple expenses should be summed correctly
        let viewModel = BudgetViewModel()

        viewModel.addExpense(name: "Item 1", amount: 10.0)
        viewModel.addExpense(name: "Item 2", amount: 20.0)
        viewModel.addExpense(name: "Item 3", amount: 30.0)
        viewModel.addExpense(name: "Item 4", amount: 40.0)

        #expect(viewModel.expenses.count == 4)
        #expect(viewModel.remainingBudget == 400.0)
    }

}
