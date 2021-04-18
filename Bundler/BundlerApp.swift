//
//  BundlerApp.swift
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//

import SwiftUI

@main
struct BundlerApp: App {
    var body: some Scene {
        WindowGroup {
            ApplicationListView()
                .accentColor(Color(.systemPink))
        }
    }
}
