//
//  RecipesListTableHeaderViewController.swift
//  RecipesBook
//
//  Created by Admin on 02/07/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class RecipesListTableHeaderView: UIView, UISearchBarDelegate  {
    
    var parentDelegate : RecipesListViewController!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var sortingButton: UIButton!
    
    var sortingType = SortingType.name {
        didSet {
            switch self.sortingType {
            case SortingType.name:
                sortingButton.setImage(#imageLiteral(resourceName: "icons8-сортировка-по-алфавиту-filled-100"), for: .normal)
            case SortingType.updated:
                sortingButton.setImage(#imageLiteral(resourceName: "icons8-поиск-по-времени-100"), for: .normal)
            default:
                sortingButton.setImage(#imageLiteral(resourceName: "icons8-сортировка-по-алфавиту-filled-100"), for: .normal)
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
        let nib = UINib(nibName: "RecipesListTableHeaderView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        parentDelegate.search(text: searchText, sortingType: self.sortingType)
    }
    
    @IBAction func onSortingButton(_ sender: Any) {
        switch self.sortingType {
        case SortingType.name:
            sortingType = SortingType.updated
        case SortingType.updated:
            sortingType = SortingType.name
        default:
            sortingType = SortingType.updated
        }
        
        parentDelegate.sort(sortingType: self.sortingType)
    }
}
