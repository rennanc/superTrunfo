//
//  Game.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 01/10/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import Foundation
import ObjectMapper

//atributos da partida
struct Round : Mappable{
    var playerMoves : [PlayerMove] = [PlayerMove]()
    var dateCreation : Date = Date()
    var nameSkill: String!
    
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        playerMoves                <- map["playerMoves"]
        dateCreation           <- map["dateCreation"]
        nameSkill           <- map["nameSkill"]
        
    }
}
