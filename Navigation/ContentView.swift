//
//  ContentView.swift
//  Navigation
//
//  Created by Myron Snelson on 6/6/26.
//
// The problem with a simple NavigationLink
// Handling navigation the smart way
//  with navigationDestination()
// Programmatic navigation with NavigationStack
// Navigating to different data types
//  using NavigationPath
// How to make a NavigationStack return
//  to its root view programmatically

import SwiftUI

/*
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
                // Tap me will show up on the origin screen
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
 */

/*
// First, we will show the simplest version of navigation
//  with a label (Tap me) and a destination view (Text(Detail View)
//  in a single navigation link
struct ContentView: View {
    var body: some View {
        NavigationStack {
            // Tap me will show up on the origin screen
            NavigationLink("Tap me") {
                // This is a simple destination view
                // It will actually slide in when
                //  you press the Tap me link
                // SwiftUI will automatically create
                //  a back button to return from the Detail View
                //  to the Content View
                Text("Detail View")
            }
        }
    }
}
*/

/*
// For more advanced navigation, it is better to
//  separate the destination from the value
// Doing so allows SwiftUI to load the destination
//  only when it is actually needed
// IMPORTANT: separating the destination from the value
//  requires two steps
// 1) We attach a value to the naviagation link
//    It can be any value you want (e.g. string, integer,
//    custom struct)
//    But that value must conform to the Hashable protocol
//    The good news: SwiftUIs built-in types conform to Hashable
// 2) We attach a new modifier called navigation destination
//    somewhere inside the navigation stack
//    telling it what to do when it receives your data
struct ContentView: View {
    var body: some View {
        NavigationStack {
            // Tap me will show up on the origin screen
            List(0..<100) { i in
                // Hashable not required for simple integers
                NavigationLink("Select \(i)", value: i)
            }
            // This will be the navigation for all integers
            //  SwiftUI will give us the actual Int (i) and
            //  return the correct SwiftUI view for integers
            // If you had several types of data,
            //  you could have multiple navigation destinations
            // This view will slide in and have a back button
            .navigationDestination(for: Int.self) { selection in
                    Text("You selected \(selection)")
            }
        }
    }
}
*/

/*
// Using the Hashable protocol with a custom struct
// that contains all built-in types that
// all conform to hashable
// and it can be used in a Naviation Link

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}
struct ContentView: View {
    var body: some View {
        NavigationStack {
            // Tap me will show up on the origin screen
            List(0..<100) { i in
                // Hashable not required for simple integers
                NavigationLink("Select \(i)", value: i)
            }
            // This will be the navigation for all integers
            //  SwiftUI will give us the actual Int (i) and
            //  return the correct SwiftUI view for integers
            // If you had several types of data,
            //  you could have multiple navigation destinations
            // This view will slide in and have a back button
            .navigationDestination(for: Int.self) { selection in
                    Text("You selected \(selection)")
            }
            // This is just an illustration of using a Hashable
            //  custom struct as a nivigation destination
            // It is NOT used in the program as there is no
            //  navigation link using the custom struct Student
            .navigationDestination(for: Student.self) { student in
                    Text("You selected \(student.name)")
            }
        }
    }
}
 */

// Programmatic navigation allows us to
// move from one view to another
// just using code
// rather than waiting for the user to
// take some kind of action
// This is done by binding the path of
// the navigation stack to an array of
// whatever data you are trying to
// navigate with
// IMPORTANT: You can mix user navigation
// and programmatic navigation
// as much as you want

/*
struct ContentView: View {
    // First, we create state property
    // that is an array of integers
    @State private var path = [Int]()
    
    var body: some View {
        // Second, we bind our array to the
        // navigation stack
        // The result: changing the array
        // will automatically navigate to
        // whatever is used inside the array
        // It becomes the active live path for
        // for navigation
        // But also, if we change the UI
        // (e.g. press the back button),
        // it will update the array automatically
        // This is called a two-way binding
        NavigationStack(path: $path) {
           VStack {
               // Set the entire array to just 32
               // Anything else that happens to be in
               // the path array is removed
               // So navigation stack goes back
               // to its original state (original view)
               // and then it will navigate to the number 32
               Button("Show 32") {
                   path = [32]
               }
               // Here we append 64, so whatever
               // happens to be in there already is
               // left there and on to a new screen even
               // deeper than that
               // So if we aleady had some information
               // in there, we now have extra views in the
               // stack
               // We will have the root view (original view)
               // then starting to show number 64
               Button("Show 64") {
                   path.append(64)
               }
               // Will first go to view 64
               // Then when you press the back button,
               // the 32 view will be shown,
               // then when you press the back button again,
               // you will be back to the content view
               // IMPORTANT: The elements in the path array
               //  set the navigation path
                Button("Show 32 then 64") {
                       path = [32, 64]
                   }
            }
           .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
           }
        }
        
    }
}
 */
// Navigating to different data types takes
//  two separate forms:
// 1) simplest one - navigation destination
//   with different data types, but you are not
//   trying to track the overall path
//   that is being shown
// 2) programmatic navigation with
//   different data types is more difficult
//   because we need to bind the path of our
//   navigation stack to an array of something
//   Previously we did this with an array of Ints,
//   but now we have both Ints and Strings
//   The solution: a special type called
//   NavigationPath which can hold a variety of
//   types of data in a single path
//   This works very similar to an array

/*
// Here is form 1
// We will show five numbers and five strings
// and nagigate them differently
// We can navigate to either Integer or String
// We are not trying to bind the navigation stack
struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Select integer: \(i)", value: i)
                }
                ForEach(0..<5) { i in
                    NavigationLink("Select string: \(i)", value: String(i))
                }
            }
            .navigationDestination(for: Int.self) {selection in
                Text("You selected the integer \(selection)")
            }
            .navigationDestination(for: String.self) {selection in
                Text("You selected the string \(selection)")
            }
            
        }
    }
}
 */

/*
// Here is form 2
struct ContentView: View {
    // NavigationPath is called a type eraser
    // It will store any kind of hashable data inside
    // without exposing exactly what type of data
    // each item is
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Select integer: \(i)", value: i)
                }
               
                
                ForEach(0..<5) { i in
                    NavigationLink("Select string: \(i)", value: String(i))
                }
            }
            .toolbar {
                // IMPORTANT: Notice the view knows what type of data
                // (Int or String) should be shown and displays the
                // correct type of navigation destination
                Button("Push 556") {
                    path.append(556)
                }
                Button("Push Hello") {
                    path.append("Hello")
                }
            }
            
            .navigationDestination(for: Int.self) {selection in
                Text("You selected the integer \(selection)")
            }
            .navigationDestination(for: String.self) {selection in
                Text("You selected the string \(selection)")
            }
            
        }
    }
}
*/

// It is common to be several layers deep in a
// navigation stack and then need to return to
// the very beginning
// We will make a little sandbox than can push
// to new views endlessly by making new
// random numbers every time

// We have two options to do this:
// A1) Have a simple array for our path
//    and then you simply call remove all
//    Removing everything in the path
//    array will send us back to the original view
// A2) However, if you are using NavigationPath,
//    perhaps when you are using a more than one
//    data type in the path, then you must make
//    a new instance of your navigation path
//    and assign that to your path effectively
//    wiping clean the path which will send
//    us back to the original view
//
// IN EITHER CASE: We have a bigger problem:
// How can we do either from the subview when
// we don't have access to the original path property?
// B1) You could store your path in an external class
//    that uses the Observable macro
// B2) Or, as we will do here, we can use the
//    property wrapper Binding
//    Binding lets us pass a piece of State
//    into another view where
//    we can modify it there
//    This is effectively having a
//    shared State value, and changing it
//    one place will change it in all other places
// IMPORTANT: Sharing a binding like this is
// very common

// Detail view that shows its current number
// as its title
// Then has a button that pushes it to a new
// random number when it is pressed
struct DetailView: View {
    // The number being passed into it
    var number: Int
    
// Option A1 and B2
//    @Binding var path: [Int]
// Options A2 and B2
    @Binding var path: NavigationPath
    
    // Show link that will push to a random number
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 0...1000))
        // show the random number in the new view
        // as a title
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    // Options A1 and B2
                    // path.removeAll()
                    // Options A2 and B2
                    path = NavigationPath()
                }
            }
        }
    }

// We can present the DetailView from our content view
// giving it an initial value of zero
// but moving to a new DetailView every time a new
// image is shown on the screen
struct ContentView: View {
    // @State private var path = [Int]()
    // Options A2 and B2
    @State private var path = NavigationPath()
    
    var body: some View {
        // Here we bind our Navigation Stack to our path
        NavigationStack(path: $path) {
            // Initial value of zero
            // DetailView(number: 0)
            // Options A1 and B2
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    // DetailView(number: i)
                    // Options A1 and B2
                    DetailView(number: i, path: $path)
                }
        }
       
    }
}

#Preview {
    ContentView()
}
