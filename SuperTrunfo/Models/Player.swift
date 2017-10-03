//
//  Player.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 01/10/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import Foundation
import ObjectMapper

//atributos da partida
struct Player : Mappable{
    var name: String!
    var cardsId : [Int] = [Int]()
    
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name       <- map["playerName"]
        cardsId    <- map["cardsId"]
        
    }
}
