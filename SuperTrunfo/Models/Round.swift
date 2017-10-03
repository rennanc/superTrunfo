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
    var number : Int! = 0
    var playerMoves : [PlayerMove] = [PlayerMove]()
    var nameSkill: String!
    
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        number              <- map["number"]
        playerMoves         <- map["playerMoves"]
        nameSkill           <- map["nameSkill"]
        
    }
}
