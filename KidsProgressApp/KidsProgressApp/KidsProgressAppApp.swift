//
//  KidsProgressAppApp.swift
//  KidsProgressApp
//
//  Created by Abdulmohammad BAIG on 2025-10-30.
//

import SwiftUI
import Firebase

@main
struct KidsProgressAppApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

