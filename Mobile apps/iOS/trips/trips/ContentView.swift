//
//  ContentView.swift
//  trips
//
//  Created by Jan Janovec on 03.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    var body: some View {
        TabView{
            ListView(state: .upcoming)
                .tabItem {
                    Label("Upcoming", systemImage: "hourglass")
                }
            ListView(state: .past)
                .tabItem {
                    Label("Past", systemImage: "clock.arrow.circlepath")
                }
        }
    }
    
    
    
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

