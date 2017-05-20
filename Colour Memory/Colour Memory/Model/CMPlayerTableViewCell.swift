//
//  CMPlayerTableViewCell.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 25/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class CMPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPlayerRank:UILabel?
    @IBOutlet weak var lblPlayerName:UILabel?
    @IBOutlet weak var lblPlayerScore:UILabel?
    
    func fillUI(obj player:Player, indexRow:Int) -> Void {
        
        self.lblPlayerRank?.text = String(format: "%d", player.rank)
        self.lblPlayerName?.text = player.playerName
        self.lblPlayerScore?.text = String(format: "%d", player.points)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
