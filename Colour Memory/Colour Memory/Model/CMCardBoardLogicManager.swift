//
//  CMCardBoardLogicManager.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 25/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class CMCardBoardLogicManager: NSObject {

    var arr:Array<String>?
    var arrCards:Array<Card>?
    var arrSelectedCards:Array<Card>?
    override init() {
        
        super.init()
        
        self.arr = Array()
        self.arrCards = Array()
        self.arrSelectedCards = Array()
        
        self.arr?.append("Drop")
        self.arr?.append("King")
        self.arr?.append("Music")
        self.arr?.append("Star")
        self.arr?.append("Sun")
        self.arr?.append("Heart")
        self.arr?.append("Moon")
        self.arr?.append("Cloud")
        
        while (self.arrCards?.count)! < 16 {
            
            let cardName = self.arr?.randomItem()
            if self.checkTotalCard(cardName!) < 2{
                
                self.arrCards?.append(Card.init(cardName: cardName!, cardImageName: String(format:"%@.png",cardName!), index:-1))
            }
        }
    }
    
    func checkTotalCard(_ cardName:String) -> Int {
        
        var totalCard:Int = 0
        
        for o in self.arrCards!{
            
            if o.cardName == cardName{
                
                totalCard = totalCard + 1
            }
            
        }
        
        return totalCard
    }
    
    func updateCardObject(obj card:Card, update:Bool) -> Void {
        
        card.isCardFlipped = update
        card.isCardMatchFailed = update
        
    }
    
    func updateCardObjects(arr CardData:[Card],points:Int, handler:(_ reloadCardBoard:Bool, _ allCardHasbeenFlipped:Bool)->Void) -> Void {
        
        var update:Bool = false
        var needtoReloadCardBoard:Bool = false
        
        if points > 0{
            
            update = true
        }
        
        for obj in CardData{
        
            obj.isCardFlipped = update
            obj.isCardMatchFailed = update
        
        }
        
        var allCardHasbeenFlippedAction = true
        
        for o in self.arrCards!{
            
            if o.isCardFlipped == false{
                
                allCardHasbeenFlippedAction = false
                break
            }
        }
        
        if points < 0{
            
            needtoReloadCardBoard = true
        }
        
        self.arrSelectedCards?.removeAll()
        
        handler(needtoReloadCardBoard, allCardHasbeenFlippedAction)
        
    }
    
    
}
