//
//  EchoApp.swift
//  Echo
//
//  Created by Ananjan Mitra on 11/06/25.
//

import SwiftUI

@main
struct EchoApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label : {
            Label("Echo", systemImage: "arrow.right.doc.on.clipboard")
        }
    }
}
