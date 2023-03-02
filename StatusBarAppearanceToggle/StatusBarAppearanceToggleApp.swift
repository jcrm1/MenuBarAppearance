//
//  StatusBarAppearanceToggleApp.swift
//  StatusBarAppearanceToggle
//
//  Created by jcrm1 on 2/24/23.
//

import SwiftUI

@main
struct StatusBarAppearanceToggleApp: App {
    let lightModeIcon = "sun.max.circle"
    let darkModeIcon = "moon.circle.fill"
    @State var mode: String = "sun.max.circle"
    var body: some Scene {
        MenuBarExtra("1", systemImage: "\(mode)") {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("Light") {
                        DispatchQueue.global(qos: .userInitiated).async {
                            let script = "tell application \"System Events\"\ntell appearance preferences\nset dark mode to false\nend tell\nend tell"
                            var error: NSDictionary?
                            if let scriptObject = NSAppleScript(source: script) {
                                scriptObject.executeAndReturnError(&error)
                                if (error != nil) {
                                    print("error: \(String(describing: error))")
                                    mode = darkModeIcon
                                }
                            }
                        }
                        mode = lightModeIcon
                    }
                    .keyboardShortcut("1")
                    Button("Dark") {
                        DispatchQueue.global(qos: .userInitiated).async {
                            let script = "tell application \"System Events\"\ntell appearance preferences\nset dark mode to true\nend tell\nend tell"
                            var error: NSDictionary?
                            if let scriptObject = NSAppleScript(source: script) {
                                scriptObject.executeAndReturnError(&error)
                                if (error != nil) {
                                    print("error: \(String(describing: error))")
                                    mode = lightModeIcon
                                }
                            }
                        }
                        mode = darkModeIcon
                    }
                    .keyboardShortcut("2")
                    Spacer()
                }
                Spacer()
            }
            .fixedSize()
        }
        .menuBarExtraStyle(WindowMenuBarExtraStyle())
        .defaultSize(CGSize(width: 50.0, height: 50.0))
    }
}
