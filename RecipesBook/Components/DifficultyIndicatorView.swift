//
//  DifficultyIndicatorView.swift
//  RecipesBook
//
//  Created by Admin on 03/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DifficultyIndicatorView : UIView {
    
    @IBOutlet private weak var hat1: UIImageView!
    @IBOutlet private weak var hat2: UIImageView!
    @IBOutlet private weak var hat3: UIImageView!
    @IBOutlet private weak var hat4: UIImageView!
    @IBOutlet private weak var hat5: UIImageView!
    
    @IBOutlet private var contentView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "DifficultyIndicatorView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func setDifficulty(value: Int) {
        let hats : [UIImageView] = [self.hat1, self.hat2, self.hat3, self.hat4, self.hat5]
        for i in 0..<value {
            hats[i].isHidden = false
        }
        for i in value..<5 {
            hats[i].isHidden = true
        }
    }
    
}
