import SwiftUI

struct ContentView: View {
    @ObservedObject var ViewModel:EmojiMemoryGame
    
    var body: some View {
        
        
        
        
        VStack {
            HStack {
                Text(ViewModel.themeName).font(.largeTitle)
                Spacer()
                Text("Score \(ViewModel.score)").font(.largeTitle)
            }
            .padding()
            ScrollView
            {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))])
                {
                    ForEach(ViewModel.cards){ card in
                        CardView(card: card).aspectRatio(2/3, contentMode:  .fit)
                            .onTapGesture{
                                ViewModel.choose(card)
                            }
                    }
                        
                        
                }
                    
                    
            }
            .foregroundColor(ViewModel.themeColor)
            .padding(.horizontal)
            Button(action: {
                ViewModel.newGame()
            }, label:
                    {
                Text("New Game").font(.largeTitle)
            })
        }
        
    }
    
  

}



struct CardView: View{    //this is just a view that shows what a card looks like.
    
    let card: MemoryGame<String>.Card
    
    var body: some View{
        
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius:20)
            
            if card.isFaceUp
            {
                
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
                
                
                
            }
            else if card.isMatched
            {
                shape.opacity(0)
            }
            else
            {
                shape.fill()
                
                    
            }
            
        }
       
        
    }
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(ViewModel: game)
      
    }
}
