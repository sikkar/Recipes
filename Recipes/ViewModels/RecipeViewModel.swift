//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Angel Escribano on 1/3/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit

class RecipeViewModel: NSObject {
    
    private let recipeService = RecipeService()
    var recipeList: [Recipe] = []

    func requestRecipeWithName(name: String, page: Int, completion: @escaping((Error?) -> Void)){
        recipeService.getRecipes(with: name, page:page) { [weak self] recipes, error in
            guard let strongSelf = self else {return}
            if let requestError = error {
                print(requestError)
                completion(requestError)
            } else {
                if let recipesArray = recipes, !recipesArray.isEmpty {
                    if page == 1 {
                        strongSelf.recipeList.removeAll()
                    }
                    strongSelf.recipeList.append(contentsOf: recipesArray) 
                    completion(nil)
                }
            }
        }
    }
    
}
