//
//  ClipboardViewModel.swift
//  Echo
//
//  Created by Ananjan Mitra on 11/06/25.
//

import Foundation
import Combine
import AppKit
    
class ClipboardViewModel: ObservableObject {
    @Published var clipboardText: String = "Empty"
    @Published var textFromMobile: String = ""
    private var cancellable: Cancellable?

    init() {
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .map { _ in {
                    getLatestItemFromDb() { (item) in
                        if item != self.textFromMobile {
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString(item, forType: .string)
                            self.textFromMobile = item
                        }
                    }
                    if NSPasteboard.general.string(forType: .string) != nil  && (NSPasteboard.general.string(forType: .string) ?? "Empty") != self.clipboardText && (NSPasteboard.general.string(forType: .string) ?? "") != self.textFromMobile {
                        addItemToDb(item: NSPasteboard.general.string(forType: .string) ?? "")
                    }
                    return NSPasteboard.general.string(forType: .string) ?? "Empty"
                }()
            }
            .removeDuplicates()
            .assign(to: \.clipboardText, on: self)
    }
}
