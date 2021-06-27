//
//  NotesCoreDataApp.swift
//  NotesCoreData
//
//  Created by Admin on 21.06.2021.
//

import SwiftUI

@main
struct NotesCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
