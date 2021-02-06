//
//  RecordItemCell.swift
//  ToastmasterTimer
//
//  Created by April Yang on 2020/9/4.
//  Copyright © 2020 April Yang. All rights reserved.
//

import UIKit

class RecordItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var usedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configure(recordItem: RecordItem) {
        self.nameLabel.text = recordItem.name
        self.totalLabel.text = formatTimeString(second: recordItem.totalTime)
        self.usedLabel.text = formatTimeString(second: recordItem.usedTime)
        self.usedLabel.textColor = recordItem.usedTime - recordItem.totalTime > 15 ? UIColor.systemRed :
            recordItem.usedTime - recordItem.totalTime < -15 ? UIColor.systemGreen :
            UIColor.darkText
    }
    
    func setAsHeader() {
        self.nameLabel.text = "name"
        self.totalLabel.text = "total"
        self.usedLabel.text = "used"
        self.usedLabel.textColor = UIColor.darkText
    }
}
