//
//  CNSettingCell.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 10/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNSettingCell: UITableViewCell {
    
    
    @IBOutlet weak var segmentSort: UISegmentedControl!
    
    @IBOutlet weak var segmentSync: UISegmentedControl!
    
    @IBOutlet weak var btnTrash: UIButton!
    
    @IBOutlet weak var btnChangePassword: UIButton!
    
    
    @IBOutlet weak var imageTxtBG: UIImageView!
    
    @IBOutlet weak var lblLoginEmail: UILabel!
    
    @IBOutlet weak var btnSignOut: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
