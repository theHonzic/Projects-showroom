//
//  tripsApp.swift
//  trips
//
//  Created by Jan Janovec on 03.06.2021.
//

import SwiftUI

@main
struct tripsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
