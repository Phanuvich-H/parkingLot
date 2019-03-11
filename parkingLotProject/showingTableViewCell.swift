//
//  showingTableViewCell.swift
//  parkingLotProject
//
//  Created by Phanuvich Hirunsirisombut on 10/28/2560 BE.
//  Copyright © 2560 Phanuvich Hirunsirisombut. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
class showingTableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avaLabel: UILabel!
    @IBAction func reserveButton(_ sender: Any) {
        
    }
    func setupCell(id: String, time:String ){
        self.idLabel.text = id
        self.timeLabel.text = time
//        self.avaLabel.text = ava
        
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
