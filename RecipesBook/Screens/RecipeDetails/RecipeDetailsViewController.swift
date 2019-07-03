//
//  RecipeDetailsViewController.swift
//  RecipesBook
//
//  Created by Admin on 01/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Auk

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var recipeInstructions: UILabel!
    @IBOutlet weak var recipeImages: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var difficultyIndicatorContainer: UIView!
    
    let difficultyIndicator = UINib(nibName: "DifficultyIndicatorView", bundle: nil)
    
    
    var viewModel : RecipeDetailsViewModel! {
        didSet {
            viewModel.recipe.bind = {[unowned self] in
                self.recipeTitle.text = $0.name
                self.recipeDescription.text = $0.description
                self.recipeInstructions.attributedText = $0.instructions.htmlAttributed(family: nil, size: 17)
                for image in $0.images {
                    self.recipeImages.auk.show(url: image)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.containerView.layer.shadowColor = UIColor.shadow.cgColor
        self.containerView.layer.shadowOpacity = 0.5
        self.containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.containerView.layer.shadowRadius = 10
        self.containerView.layer.masksToBounds = false
        

        
        guard let recipe = viewModel.recipe.value else {
            return
        }
        
        let difficultyIndicatorView = difficultyIndicator.instantiate(withOwner: self, options: nil).first as? DifficultyIndicatorView
        difficultyIndicatorView?.setDifficlty(value: recipe.difficulty)
        
        difficultyIndicatorContainer.addSubview(difficultyIndicatorView ?? UIView())
        
        
        self.recipeTitle.text = recipe.name
        self.recipeDescription.text = recipe.description
        self.recipeInstructions.attributedText = recipe.instructions.htmlAttributed(family: nil, size: 12)
        for image in recipe.images {
            recipeImages.auk.show(url: image)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(self.isMovingFromParent) {
            viewModel.goBack()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

    }

}
