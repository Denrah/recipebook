//
//  DifficultyIndicatorView.swift
//  RecipesBook
//
//  Created by Admin on 03/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DifficultyIndicatorView : UIView {

    
    @IBOutlet weak var difficultyBar: UIView!
    @IBOutlet weak var difficultyValue: UILabel!
    @IBOutlet weak var barWidthConstraint: NSLayoutConstraint!
    
    func setDifficlty(value: Int) {
        difficultyValue.text = "\(value)/5"
        barWidthConstraint.constant = CGFloat(20 * value)
        difficultyBar.layoutIfNeeded()
    }
    
}
