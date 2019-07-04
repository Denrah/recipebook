protocol RecipesListViewControllerDelegate : class {
    func search(text: String, sortingType: SortingType) -> Void
    
    func sort(sortingType: SortingType) -> Void
}
