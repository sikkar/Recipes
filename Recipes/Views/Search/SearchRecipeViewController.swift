//
//  SearchRecipeViewController.swift
//  Recipes
//
//  Created by Angel Escribano on 1/3/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit
import Instructions

class SearchRecipeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var recipesTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private let recipeViewModel = RecipeViewModel()
    var coachMarkHelper: CoachMarkHelper = CoachMarkHelper()
    let tutorialKey = "tutorialKey"
    let recipeCellIdentifier = "recipeCellIdentifier"
    var currentPage = 1
    var currentRecipe = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupInstructions()
    }

    private func setupView(){
        self.navigationController?.navigationBar.isHidden = true
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        recipesTableView.register(UINib.init(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: recipeCellIdentifier)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchRecipes(_:)), object: textField)
        perform(#selector(self.searchRecipes(_:)), with: textField, afterDelay: 0.3)
    }
    
    @objc func searchRecipes(_ textField:UITextField){
        if let text = textField.text, text.trimmingCharacters(in: .whitespaces) != "" {
            currentRecipe = text
            currentPage = 1
            recipeViewModel.requestRecipeWithName(name: text, page: currentPage) { [weak self] error in
                guard let strongSelf = self else {return}
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    strongSelf.recipesTableView.reloadData()
                }
            }
        } else {
            recipeViewModel.recipeList.removeAll()
            recipesTableView.reloadData()
        }
    }
    
    func getMoreRecipes(){
        currentPage += 1
        recipeViewModel.requestRecipeWithName(name: currentRecipe, page: currentPage) { [weak self] error in
            guard let strongSelf = self else {return}
            if let error = error{
                print(error.localizedDescription)
            } else {
                strongSelf.recipesTableView.reloadData()
            }
        }
    }
}

extension SearchRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeViewModel.recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellIdentifier, for: indexPath) as! RecipeTableViewCell
        
        let recipe = recipeViewModel.recipeList[indexPath.row]
        cell.recipe = recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == recipeViewModel.recipeList.count - 1) {
            getMoreRecipes()
        }
    }
}

extension SearchRecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipeViewModel.recipeList[indexPath.row]
        if let recipeUrl = recipe.href, let url = URL(string: recipeUrl) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

