//
//  CMCardCollectionViewCell.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 22/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

protocol CMCardCollectionViewCellDelegate {
    
    func sendPoint(_ point:Int) -> Void
    func updateCellIndex(_ index:IndexPath) -> Void
}

class CMCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnCard:CMCustomButton!
    var delegate:CMCardCollectionViewCellDelegate!
    var objCard:Card!
    
    func fillCard(objCard card:Card, index:IndexPath) -> Void {
    
        self.objCard = card
        self.objCard.index = index.row
        
        self.btnCard.setImage(UIImage(named: ""), for: [])
    }
    
    @IBAction func flipCard(_ btnObject:CMCustomButton){
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        if app.totalCardSwiped >= 2{
            
            return
        }
        
        if self.objCard.isCardFlipped == false{
        
            self.delegate.updateCellIndex(IndexPath(row: self.objCard.index, section: 0))
            
            if let app = UIApplication.shared.delegate as? AppDelegate{
                
                app.totalCardSwiped = app.totalCardSwiped + 1
                if app.firstCardName.characters.count == 0{
                    
                    app.firstCardName  = self.objCard.cardImageName
                    
                }else{
                    
                    app.secondCardName = self.objCard.cardImageName
                }
            }
            
            weak var ___weakSelf = self
            
            UIView.transition(with: btnObject, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
                
                btnObject.setImage(UIImage(named: self.objCard.cardImageName), for: UIControlState())
                
            }, completion: {(action:Bool)->Void in
            
                if app.totalCardSwiped == 2{
                    
                    if app.firstCardName == app.secondCardName{
                        
                        ___weakSelf?.delegate.sendPoint(2)
                        
                    }else{
                        
                        ___weakSelf?.delegate.sendPoint(-1)
                    }
                    
                    
                    app.firstCardName = ""
                    app.secondCardName = ""
                    app.totalCardSwiped = 0
                    
                }
                
            })
            
            
            
        }
        
    }
    
}
