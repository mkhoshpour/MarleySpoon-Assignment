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
        if let url = item.photo?.url {
            Service.loadImage(url: url) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.imageViewRecipe.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
