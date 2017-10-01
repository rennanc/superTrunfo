//
//  Card.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 14/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit
import ObjectMapper

//atributos da carta
struct Card : Mappable{
    var id: Int!
    var heroName: String!
    var heroImage: String!
    var skillValue1: Int!
    var skillValue2: Int!
    var skillValue3: Int!
    var skillValue4: Int!
    
    var category: String!
    var rank: Int!
    
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id 	<- map["id"]
        heroName    <- map["name"]
        rank        <- map["rank"]
        category 	<- map["category"]
        heroImage   <- map["imageUrl"]
        skillValue1 	<- map["intelligence"]
        skillValue2 	<- map["equipment"]
        skillValue3 	<- map["speed"]
        skillValue4 	<- map["strength"]
        
    }
}
