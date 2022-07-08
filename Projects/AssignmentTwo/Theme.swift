//
//  Theme.swift
//  Memorize
//
//  Created by Tom Miller on 07/07/2022.
//

import Foundation

struct Theme
{
    var name : String
    var emojis : Array<String>
    var numbersOfPairsOfCards: Int
    var color : String
    init(name: String, emojis : Array<String>, numbersOfPairsOfCards :Int, color : String)
    {
        self.name = name
        self.emojis = emojis
        self.numbersOfPairsOfCards = numbersOfPairsOfCards > emojis.count ? emojis.count :  numbersOfPairsOfCards
        self.color = color
    }
}
