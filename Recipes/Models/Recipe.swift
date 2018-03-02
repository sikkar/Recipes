//
//  Recipe.swift
//  Recipes
//
//  Created by Angel Escribano on 1/3/18.
//  Copyright © 2018 -. All rights reserved.
//

import ObjectMapper

struct Recipe: Mappable {
    
    var title: String?
    var href: String?
    var ingredients: String?
    var thumbnail: String?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.title <- map["title"]
        self.href <- map["href"]
        self.ingredients <- map["ingredients"]
        self.thumbnail <- map["thumbnail"]
    }
    
    
}
