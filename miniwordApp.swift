//
//  wordsApp.swift
//  words
//
//  Created by 章珂 on 2022/5/28.
//

import SwiftUI

@main
struct miniwordApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSettings(fontSize: 50, changeTime: 30, fontColor: .black))
        }
        Settings{
            SettingsView()
        }
        
    }
}
