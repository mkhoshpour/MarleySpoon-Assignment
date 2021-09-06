//
//  RecipeCell.swift
//  Marley Spoon
//
//  Created by Majid Khoshpour on 9/6/21.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var imageViewRecipe: UIImageView!
    @IBOutlet weak var labelRecipeName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // Image View
        imageViewRecipe.layer.cornerRadius = 15
        imageView?.layer.masksToBounds = true
    }

    func configureCellWith(_ item: Recipe) {
        labelRecipeName.text = item.title
        imageViewRecipe.image = item.photo?.urlString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
