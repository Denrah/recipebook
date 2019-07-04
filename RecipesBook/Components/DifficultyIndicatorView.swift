//
//  DifficultyIndicatorView.swift
//  RecipesBook
//
//  Created by Admin on 03/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DifficultyIndicatorView : UIView {
    
    @IBOutlet weak var hat1: UIImageView!
    @IBOutlet weak var hat2: UIImageView!
    @IBOutlet weak var hat3: UIImageView!
    @IBOutlet weak var hat4: UIImageView!
    @IBOutlet weak var hat5: UIImageView!
    
    func setDifficlty(value: Int) {
        let hats : [UIImageView] = [self.hat1, self.hat2, self.hat3, self.hat4, self.hat5]
        for i in 0..<value {
            hats[i].isHidden = false
        }
        for i in value..<5 {
            hats[i].isHidden = true
        }
    }
    
}
