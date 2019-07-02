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
        self.recipeInstructions.attributedText = recipe.instructions.htmlAttributed(family: nil, size: 17)
        recipe.images.map { (image) -> Void in
            recipeImages.auk.show(url: image)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(self.isMovingFromParent) {
            viewModel.goBack()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
