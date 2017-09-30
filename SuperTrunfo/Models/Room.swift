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
    var id: Int!
    var name: String!
    var challenger: String!
    var distance: Double!
    var image: UIImage!
    var available : Bool!
    var latitude : Double!
    var longitude : Double!
        
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        available           <- map["available"]
        latitude            <- map["latitude"]
        longitude           <- map["longitude"]
        
    }
}
