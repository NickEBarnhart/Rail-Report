//
//  StorageTableViewCell.swift
//  Siemens_Reporter
//
//  Created by Nicholas Barnhart on 3/21/17.
//  Copyright © 2017 Nicholas Edward Barnhart. All rights reserved.
//

import UIKit

class StorageTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var dateItem: UILabel!
    @IBOutlet weak var descriptionItem: UILabel!
    @IBOutlet weak var dayItem: UILabel!
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var imageItem2: UIImageView!
    @IBOutlet weak var imageItem3: UIImageView!
    
    @IBOutlet weak var locationItem: UILabel!

    
    @IBOutlet weak var observationItem: UILabel!

    
    @IBOutlet weak var actionItem: UILabel!
    
    @IBOutlet weak var impactItem: UILabel!

    
    @IBOutlet weak var workerItem: UILabel!

    
    @IBOutlet weak var countItem1: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
