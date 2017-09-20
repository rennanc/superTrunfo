//
//  CardsApi.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 17/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import Foundation
import Alamofire

class CardService {
    
    
    /*
    * Servicos para obter cartas para o jogador
    */
    func getCards() -> [Card]{
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        var cards : [Card] = [Card]()
        
        for i in 0...7 {
            var card : Card = Card()
            card.id = i
            card.heroName = "Homem Aranha" + String(i)
            card.heroImage =  UIImage(named: "add")
            card.skillValue1 = Int(arc4random_uniform(10))
            card.skillValue2 = Int(arc4random_uniform(10))
            card.skillValue3 = Int(arc4random_uniform(10))
            card.skillValue4 = Int(arc4random_uniform(10))
            
            cards.append(card)
        }
        
        return cards
    }
    
    func getChallengerMove() -> PlayerMove{
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        return PlayerMove()
    }
}
