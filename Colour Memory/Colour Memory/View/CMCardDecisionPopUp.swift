//
//  CMCardDecisionPopUp.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 26/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class CMCardDecisionPopUp: UIView {

    @IBOutlet weak var lblTitle:UILabel?
    @IBOutlet weak var lblDesc:UILabel?
    
    @IBOutlet weak var viewPopUp:UIView?
    
    var point:Int16!
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.viewPopUp?.layer.cornerRadius = 20
        self.viewPopUp?.layer.borderColor  = UIColor.clear.cgColor
        self.viewPopUp?.layer.borderWidth  = 0.0
        self.viewPopUp?.clipsToBounds = true
        
        self.viewPopUp?.backgroundColor = UIColor.lightGray
        
    }
    
    func loadUI(score:Int16) -> Void {
        
        if score < 0{
            
            self.lblTitle?.text = "Incorrect"
            self.lblTitle?.textColor = UIColor.red
            
            self.lblDesc?.text = "You lost 1 point"
            
        }else{
            
            self.lblTitle?.text = "Correct"
            self.lblTitle?.textColor = UIColor.green
            
            self.lblDesc?.text = "You earned 2 point"
        }
        
    }
    

}
