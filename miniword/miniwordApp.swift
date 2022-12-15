//
//  miniwordApp.swift
//  miniword
//
//  Created by 章珂 on 2022/6/6.
//

import SwiftUI

@main
struct miniwordApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
