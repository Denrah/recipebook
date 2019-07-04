//
//  RecipesListCell.swift
//  RecipesBook
//
//  Created by Admin on 02/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class RecipesListCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var cellTitle: UILabel!
    @IBOutlet private weak var cellDescription: UILabel!
    @IBOutlet private weak var cellUpdated: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.shadowView.layer.shadowColor = UIColor.shadow.cgColor
        self.shadowView.layer.shadowOpacity = 0.5
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.shadowView.layer.shadowRadius = 10
        self.shadowView.layer.masksToBounds = false
    }
    
    func setup(title: String, description: String?, image recipeImage: String?, updated: Int) {
        
        let date = Date(timeIntervalSince1970: TimeInterval(updated))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        cellTitle.text = title
        cellDescription.text = description ?? ""
        
        if let image = recipeImage {
            cellImage.kf.setImage(with: URL(string: image))
        } else {
            cellImage.image = #imageLiteral(resourceName: "andy-chilton-0JFveX0c778-unsplash")
        }
        
        cellUpdated.text = "Last updated: " + dateFormatter.string(from: date)
    }
}
