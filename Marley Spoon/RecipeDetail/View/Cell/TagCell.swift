//
//  TagCell.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/7/21.
//

import UIKit

class TagCell: UICollectionViewCell {

    @IBOutlet weak var labelTagName: UILabel!
    @IBOutlet weak var innerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // Image View
        innerView.layer.cornerRadius = 15
        innerView.layer.masksToBounds = true
    }

    func configureCellWith(_ item: Tag) {
        labelTagName.text = item.name

    }
}
