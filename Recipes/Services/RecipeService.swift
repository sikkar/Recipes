//
//  RecipeService.swift
//  Recipes
//
//  Created by Angel Escribano on 1/3/18.
//  Copyright © 2018 -. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class RecipeService: NSObject {
    
    private let baseUrl = "http://www.recipepuppy.com/api/"

    func getRecipes(with name: String, page: Int, completionHandler: @escaping([Recipe]?, Error?) -> Void){
        
        let parameters:[String:Any] = ["q":name,
                                       "p":page]
        
        let request = Alamofire.request(baseUrl, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil).responseArray(queue: DispatchQueue.main, keyPath: "results") { (response: DataResponse<[Recipe]>) in
            if response.result.isSuccess {
                if let recipes = response.result.value {
                    completionHandler(recipes,nil)
                }
            } else {
                completionHandler(nil,response.error)
            }
        }
        print(request.debugDescription)
    }
    
}
