//
//  RecipesListViewController.swift
//  RecipesBook
//
//  Created by Admin on 01/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {
    
    var viewModel: RecipesListViewModel! {
        didSet {
            viewModel.isLoading.bind = {[weak self] in
                guard let self = self else {return}
                self.preloadingView.isHidden = !$0
            }
            
            viewModel.recipes.bind = {[weak self] in
                guard let self = self else {return}
                
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
                self.placeholderView.isHidden = !self.recipesData.recipes.isEmpty
            }
        }
    }
    
    private var recipesData = RecipesData()
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet private weak var preloadingView: UIView!
    @IBOutlet private weak var placeholderView: UIView!
    @IBOutlet private weak var backgroundView: UIView!
    
    @IBOutlet private weak var recipesTableView: UITableView! {
        didSet {
            let tableCell = UINib(nibName: Constants.RecipesListTableCellName, bundle: nil)
            recipesTableView.register(tableCell, forCellReuseIdentifier: Constants.RecipesListCellIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        recipesTableView.refreshControl = refreshControl
        
        let tableHeaderView = RecipesListTableHeaderView(frame: CGRect(x: 0, y: 0,
                                                                       width: view.bounds.width, height: 190))
        
        tableHeaderView.parentDelegate = self
        
        recipesTableView.tableHeaderView = tableHeaderView

        setGradient(view: backgroundView)
        
        viewModel.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

extension RecipesListViewController {
    
    private func setGradient(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.primary.cgColor, UIColor.primaryDarker.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = backgroundView.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension RecipesListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesData.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RecipesListCellIdentifier) as? RecipesListCell else {
            return UITableViewCell()
        }
        
        var image: String? = nil
        
        if recipesData.recipes[indexPath.row].images.count > 0 {
            image = recipesData.recipes[indexPath.row].images[0]
        }
        
        cell.setup(title: recipesData.recipes[indexPath.row].name,
                   description: recipesData.recipes[indexPath.row].description,
                   image: image,
                   updated: recipesData.recipes[indexPath.row].lastUpdated)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToRecipeDetails(index: indexPath.row)
    }
    
    @objc func refreshData() {
        viewModel.updateRecipes {[weak self] in
            guard let self = self else {return}
            self.recipesTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension RecipesListViewController : RecipesListViewControllerDelegate {
    func search(text: String, sortingType: SortingType) {
        viewModel.searchRecipes(text: text, sortingType: sortingType)
    }
    
    func sort(sortingType: SortingType) {
        viewModel.sortRecipes(sortingType: sortingType)
    }
}
