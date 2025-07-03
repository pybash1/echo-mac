//
//  ContentView.swift
//  Echo
//
//  Created by Ananjan Mitra on 11/06/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var clipboardModel = ClipboardViewModel()

    var body: some View {
        VStack {
            Text(clipboardModel.clipboardText.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n")[0].prefix(30) + (clipboardModel.clipboardText.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n")[0].count > 30 ? "..." : ""))
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}

#Preview {
    ContentView()
}
