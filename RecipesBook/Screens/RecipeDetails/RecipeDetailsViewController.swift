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
    
    @IBOutlet private weak var recipeTitle: UILabel!
    @IBOutlet private weak var recipeDescription: UILabel!
    @IBOutlet private weak var recipeInstructions: UILabel!
    @IBOutlet private weak var recipeImages: UIScrollView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var difficultyIndicator: DifficultyIndicator!
    @IBOutlet private weak var imagesPlaceholder: UIView!
    
    var viewModel: RecipeDetailsViewModel! {
        didSet {
            viewModel.recipe.bind = {[weak self] in
                
                guard let self = self else {return}
                
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
        
        setCardShadow(view: containerView)
        
        guard let recipe = viewModel.recipe.value else {
            return
        }
        
        difficultyIndicator.value = recipe.difficulty
        
        self.recipeTitle.text = recipe.name
        self.recipeDescription.text = recipe.description ?? "-"
        self.recipeInstructions.attributedText = recipe.instructions.htmlAttributed(family: nil, size: 12)
        for image in recipe.images {
            recipeImages.auk.show(url: image)
        }
        
        if recipe.images.count > 0 {
            imagesPlaceholder.removeFromSuperview()
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

extension RecipeDetailsViewController {
    private func setCardShadow(view: UIView) {
        view.layer.shadowColor = UIColor.shadow.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
    }
}
