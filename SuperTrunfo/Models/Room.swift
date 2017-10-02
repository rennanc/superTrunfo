//
//  Room.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 14/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit
import ObjectMapper

//Dados da Celula da sala
struct Room : Mappable{
    var id: String!
    var name: String!
    var creator: String!
    var distance: Double!
    var image: UIImage!
    var available : Bool!
    var latitude : Double!
    var longitude : Double!
    
    var rounds : [Round]! = [Round]()
    var players : [Player]! = [Player]()
        
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        creator             <- map["creator"]
        available           <- map["available"]
        latitude            <- map["latitude"]
        longitude           <- map["longitude"]
        players             <- map["players"]
        rounds              <- map["rounds"]
        
    }
}
