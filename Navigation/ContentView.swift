//
//  ContentView.swift
//  Navigation
//
//  Created by Myron Snelson on 6/6/26.
//
// The problem with a simple NavigationLink

import SwiftUI

struct DetailView: View {
    var number: Int
    var body: some View {
        Text("Detail View \(number)")
    }
    // We start with the default initializer
    // but we add a print statement
    init(number: Int) {
        self.number = number
        // THE PROBLEM:
        // Just showing the navigation link on the screen
        // causes SwiftUI to automatically create a detail view
        // inside it
        // In this case, this print statement is run
        // even before the "Tap Me" link is tapped
        // That's okay when the code is doing something simple
        // like just one print statement
        print("Creating Detail View with \(number)")
    }
}
struct ContentView: View {
    var body: some View {
        // Simple screen linkage
        NavigationStack {
            List (0..<1000) { i in
                NavigationLink("Tap me") {
                    // This is a placeholder destination view
                    // Text("Detail View")
                    
                    // Now we will use DetailView
                    // created in the struct above
                    // But we will use it in without
                    // any complex logic surrrounding it
                    // DetailView(number: 556)
                    
                    // Now we will make the logic more complex
                    // This causes the PROBLEM detailed above
                    // to occur many times - very inefficient
                    // It is the dynamic data that is
                    // causing the problem
                    // Static data is no big deal
                    // Dynamic data can be hugely inefficient
                    
                    // A presentation value solves this problem
                    DetailView(number: i)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
