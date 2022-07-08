//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tom Miller on 27/06/2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable //MemoryGame is the model for the MVVM pattern
{
    
    private(set) var score : Int = 0
    private(set) var cards : Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card)
    {
        if let chosenIndex = cards.firstIndex(where: {  $0.id==card.id  }),  !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            /*
            we chose a card, basically we just made sure the card we were picking
            was really in the cards array, we also made sure the card we were picking
            was not faceUp or matched.
            
             
             
            */
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard
                //we check if there is a faceup card(by safely unwrapping the optional)
            {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content
                    //there is a faceup card, and we just chose another card. so lets see if the content of both those cards are equivalent.
                {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score+=2
                    //in this the case the content of both cards were equivalent and so
                    //we set both cards to be matched, and add +2 to the score.
                    
                }
                else
                {
                    score -= 1
                    
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            else
            {
                for index in cards.indices
                {
                    if cards[index].isFaceUp
                    {
                        cards[index].isFaceUp = false
                        
                    }
                    
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
            
            
        }
        print("\(cards)")
    }
    
    init(numbersOfPairsOfCards: Int, createCardContent: (Int) -> CardContent)
    {
        cards = Array<Card>()
        //add numbersOfPairsOfCards*2 to cards array.
        for pairIndex in 0..<numbersOfPairsOfCards
        {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2+1))
        }
        cards.shuffle()
        
    }
    
    struct Card : Identifiable
    {
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
