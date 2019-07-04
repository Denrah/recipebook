//
//  RecipesListViewController.swift
//  RecipesBook
//
//  Created by Admin on 01/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class RecipesListViewController: UIViewController {
    
    var viewModel : RecipesListViewModel! {
        didSet {
            
            viewModel.isLoading.bind = {[unowned self] in
                self.preloadingView.isHidden = !$0
            }
            
            viewModel.recipes.bind = {[unowned self] in
                guard let data = $0 else {
                   
                    let alert = UIAlertController(title: "Error", message: "Something wrong with your network :(", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Quit", style: .cancel, handler: { (action) in
                        exit(0)
                    }))
                    self.present(alert, animated: true)
                    return

                }
                
                self.recipesData = data
                
                self.recipesTableView.reloadData()
                
                if self.recipesData.recipes.count == 0 {
                    self.placeholderView.isHidden = false
                } else {
                    self.placeholderView.isHidden = true
                }
            }
        }
    }
    
    var recipesData = RecipesData()
    
    
    @IBOutlet weak var preloadingView: UIView!
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var recipesTableView: UITableView!
    
    let tableCell = UINib(nibName: "RecipesListCell", bundle: nil)
    
    let tableHeader = UINib(nibName: "RecipesListTableHeaderView", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.primary.cgColor, UIColor.primaryDarker.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = backgroundView.bounds
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.register(tableCell, forCellReuseIdentifier: "RecipeCell")
        
        let tableHeaderView = tableHeader.instantiate(withOwner: self, options: nil).first as? RecipesListTableHeaderView
        
        tableHeaderView?.parentDelegate = self
    
        
        tableHeaderView?.frame = CGRect(x: 0, y: 0, width: tableHeaderView?.frame.width ?? 100, height: 190)
        
        
        recipesTableView.tableHeaderView = tableHeaderView

        
       
        
        viewModel.start()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

extension RecipesListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesData.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipesListCell
        
        cell.setup(title: recipesData.recipes[indexPath.row].name, description: recipesData.recipes[indexPath.row].description?.trunc(length: 100), image: recipesData.recipes[indexPath.row].images[0], updated: recipesData.recipes[indexPath.row].lastUpdated)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToRecipeDetails(index: indexPath.row)
    }
}

extension RecipesListViewController {
    
    func search(text: String, sortingType: Int) {
        viewModel.searchRecipes(text: text, sortingType: sortingType)
    }
    
    func sort(sortingType: Int) {
        viewModel.sortRecipes(sortingType: sortingType)
    }
}
