//
//  RoomUITableCell.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 29/08/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import Foundation

import UIKit

class RoomUITableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var nameRoom: UILabel!
    @IBOutlet weak var nameChallenger: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
