//
//  CNAllNotsListCell.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 09/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNAllNotsListCell: UITableViewCell {

    @IBOutlet weak var lblTitleName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
