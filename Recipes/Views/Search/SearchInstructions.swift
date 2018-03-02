//
//  SearchInstructions.swift
//  Recipes
//
//  Created by Angel Escribano on 2/3/18.
//  Copyright © 2018 -. All rights reserved.
//

import Instructions

extension SearchRecipeViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !(UserDefaults.standard.value(forKey: tutorialKey) as? Bool ?? false) {
            self.coachMarkHelper.controller.start(on: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarkHelper.controller.stop(immediately: true)
    }
    
    func setupInstructions(){
        coachMarkHelper = CoachMarkHelper.init(views: [searchTextField],
                                               texts: [
                                                ["Enter The name of a recipe":"Ok!"]
            ],
                                               userDefaultsKey: tutorialKey)
    }
    
}
