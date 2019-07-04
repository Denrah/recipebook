//
//  RecipesListTableHeaderViewController.swift
//  RecipesBook
//
//  Created by Admin on 02/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class RecipesListTableHeaderView: UIView, UISearchBarDelegate  {
    
    var parentDelegate : RecipesListViewControllerDelegate!
    
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet private weak var sortingButton: UIButton!
    
    private var sortingType = SortingType.name {
        didSet {
            switch self.sortingType {
            case .name:
                sortingButton.setImage(#imageLiteral(resourceName: "icons8-сортировка-по-алфавиту-filled-100"), for: .normal)
            case .updated:
                sortingButton.setImage(#imageLiteral(resourceName: "icons8-поиск-по-времени-100"), for: .normal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: Constants.RecipeListTableHeaderName, bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        parentDelegate.search(text: searchText, sortingType: self.sortingType)
    }
    
    @IBAction private func onSortingButton(_ sender: Any) {
        switch self.sortingType {
        case .name:
            sortingType = .updated
        case .updated:
            sortingType = .name
        }
        
        parentDelegate.sort(sortingType: self.sortingType)
    }
}
