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
        
        
        guard let recipe = viewModel.recipe.value else {
            return
        }
        
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

    }

}
