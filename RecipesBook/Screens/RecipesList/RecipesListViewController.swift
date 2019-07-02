//
//  RecipesListViewController.swift
//  RecipesBook
//
//  Created by Admin on 01/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {
    
    var coordinator : RecipesCoordinator!
    var viewModel : RecipesListViewModel! {
        didSet {
            viewModel.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onBtn(_ sender: Any) {
        coordinator.goToRecipeDetails()
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
