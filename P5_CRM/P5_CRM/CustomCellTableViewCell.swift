//
//  CustomCellTableViewCell.swift
//  P5_CRM
//
//  Created by Sofia Vidal Urriza on 26/11/2017.
//  Copyright © 2017 Sofia Vidal Urriza. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var visitImage: UIImageView!
    @IBOutlet weak var mainTitleName: UILabel!
    @IBOutlet weak var subtitleDate: UILabel!
  
    @IBOutlet weak var targetName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
