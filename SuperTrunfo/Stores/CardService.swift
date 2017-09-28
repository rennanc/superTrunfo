 //
//  CardsApi.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 17/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CardService {
    
    
    /*
    * Servicos para obter cartas para o jogador
    */
    func getCards(completionHandler: @escaping ([Card], NSError?) -> ()) -> [Card]!{
        
        var cards = [Card]()
        
        Alamofire.request("https://infnet-ios-api.herokuapp.com/sortDeck").responseArray { (response: DataResponse<[Card]>) in
            //responseJSON { response in
            /*
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            */
            
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler([Card](), error as NSError)
            }
            
            /*
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let cardsArray = response.result.value {
                _completion?(cards)
                cards = cardsArray
            } else {
                //Handle error
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            */
        }
        /* mock
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
        }*/
        return cards
    }
    
    /*
    *   Servico para obter novas cartas do baralho para o jogador
    */
    func getGetNewCard() -> Card{
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
        
        
        var card : Card = Card()
        card.id = 1
        card.heroName = "Homem Aranha" + String(1)
        card.heroImage =  UIImage(named: "add")
        card.skillValue1 = Int(arc4random_uniform(10))
        card.skillValue2 = Int(arc4random_uniform(10))
        card.skillValue3 = Int(arc4random_uniform(10))
        card.skillValue4 = Int(arc4random_uniform(10))
        
        return card
    }
    
    /*
    * obtem a jogada do desafiante
    */
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
