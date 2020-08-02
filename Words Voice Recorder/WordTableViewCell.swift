//
//  WordTableViewCell.swift
//  Words Voice Recorder
//
//  Created by Asil Arslan on 2.08.2020.
//  Copyright © 2020 Asil Arslan. All rights reserved.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class var reuseIdentifier: String {
        return "WordTableViewCell"
    }
    class var nibName: String {
        return "WordTableViewCell"
    }

}
