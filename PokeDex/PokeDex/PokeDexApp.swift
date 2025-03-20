//
//  PokeDexApp.swift
//  PokeDex
//
//  Created by Akshay  on 2025-03-19.
//

import SwiftUI

@main
struct PokeDexApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
