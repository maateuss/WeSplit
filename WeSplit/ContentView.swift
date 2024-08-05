//
//  ContentView.swift
//  WeSplit
//
//  Created by Mateus Moura Santos on 05/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var amountPerPerson = 0
    @FocusState private var amountIsFocused: Bool
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipAmount = checkAmount / 100 * Double(tipPercentage + 1)
        return (tipAmount + checkAmount)
    }
    
    var totalPerPerson: Double {
        return totalAmount / Double(numberOfPeople + 1)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1..<35) {
                            Text($0 == 1 ? "Alone" : "\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                Section("How many tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(1..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount") {
                    Text(totalAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
