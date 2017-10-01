//
//  PlayerMove.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 15/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit
import ObjectMapper

struct PlayerMove  : Mappable{
    var cardId : String!
    var player : Player!
    var nameSkill: String!
    var valueSkill: Int!
    var image: UIImage!
    
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cardId       <- map["cardId"]
        player       <- map["player"]
        nameSkill    <- map["nameSkill"]
        valueSkill   <- map["valueSkill"]
    }
}
