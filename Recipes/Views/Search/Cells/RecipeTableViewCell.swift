//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by Angel Escribano on 2/3/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var linkLabel: UILabel!
    
    var recipe: Recipe? {
        didSet{
            bindRecipe()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func bindRecipe() {
        self.titleLabel.text = recipe?.title
        self.linkLabel.text = recipe?.href
        if let thumbnail = recipe?.thumbnail, !thumbnail.isEmpty{
            loadThumbnail(thumbnail)
        } else {
            recipeImageView.image = UIImage(named: "placeholder")!
        }
       
    }
    
    private func loadThumbnail(_ thumbnail: String){
        if let url = URL(string:thumbnail) {
            let placeholderImage = UIImage(named: "placeholder")!
            recipeImageView.kf.setImage(with: url, placeholder: placeholderImage)
        }
    }
    
}
