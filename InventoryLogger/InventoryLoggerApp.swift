//
//  InventoryLoggerApp.swift
//  InventoryLogger
//
//  Created by Hai Long Danny Thi on 2020/11/26.
//

import SwiftUI

@main
struct InventoryLoggerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(inventory: Inventory())
        }
    }
}
