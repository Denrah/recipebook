//
//  RecipesListViewController.swift
//  RecipesBook
//
//  Created by Admin on 01/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel : RecipesListViewModel! {
        didSet {
                   
            viewModel.recipes.bind = {[unowned self] in
                self.recipesData = $0
                self.recipesTableView.reloadData()
            }
        }
    }
    
    var recipesData = RecipesData()
    
    
    @IBOutlet weak var recipesTableView: UITableView!
    let nib = UINib(nibName: "RecipesListCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.register(nib, forCellReuseIdentifier: "RecipeCell")
        
        viewModel.start()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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

extension RecipesListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesData.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipesListCell
        (cell.viewWithTag(1) as! UILabel).text = recipesData.recipes[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToRecipeDetails(id: self.recipesData.recipes[indexPath.row].uuid)
    }

}
