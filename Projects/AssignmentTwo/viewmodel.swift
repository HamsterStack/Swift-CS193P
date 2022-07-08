//
//  viewmodel.swift
//  Memorize
//
//  Created by Tom Miller on 27/06/2022.
//

import SwiftUI



class EmojiMemoryGame:ObservableObject //this is the ViewModel
{
    
    
    init()
    {
        theme = EmojiMemoryGame.themes.randomElement()!
        
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    static var themes : Array<Theme> = [
        Theme(name: "Cats", emojis: ["😺", "😸", "😹", "😻", "🙀", "😿", "😾", "😼"], numbersOfPairsOfCards: 8, color: "red")
        ,
        Theme(name: "Technology", emojis: ["🤖", "👾", "🦾", "🦿", "🎮", "🖲"], numbersOfPairsOfCards: 8, color: "blue")
        ,
        Theme(name: "Zodiac", emojis: ["♌️", "♍️", "♏️", "♓️", "♉️", "♈️", "⛎", "♒️", "♋️", "♐️", "♊️", "♑️"], numbersOfPairsOfCards: 8, color: "orange")
        ,
        Theme(name: "Vegetables", emojis: ["🥦", "🍅", "🌶", "🌽", "🥕", "🥬", "🥒", "🧄", "🍆", "🧅"], numbersOfPairsOfCards: 5, color: "green")
    ]
    static func createMemoryGame(theme: Theme) -> MemoryGame<String>
    {
        MemoryGame<String>(numbersOfPairsOfCards: theme.numbersOfPairsOfCards) {  pairIndex  in theme.emojis[pairIndex]}
    }
    @Published private var model : MemoryGame<String>
    private var theme : Theme
    var score : Int
    {
        model.score
    }
    var themeName : String
    {
        theme.name
    }
    
    var themeColor : Color
    {
        switch theme.color
        {
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        case "orange":
            return .orange
        default:
            return .black
        }
    }
    
    func newGame()
    {
        /*
         clicking new game and having it change to a theme that we're already on is
         bad, if the user is unlucky they could get the same theme 5 times in a row
         after clicking new game. we want it so that if you click new game itll give you
         a NEW theme.
         */
        let oldtheme = theme.name
        
        theme = EmojiMemoryGame.themes.randomElement()!
        while theme.name==oldtheme
        {
            theme = EmojiMemoryGame.themes.randomElement()!
        }
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        
    }
    var cards: Array<MemoryGame<String>.Card>
    {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card)
    {
        model.choose(card)
    }
    
}
