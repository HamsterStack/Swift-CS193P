//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Tom Miller on 23/06/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(ViewModel: game)
        }
    }
}
