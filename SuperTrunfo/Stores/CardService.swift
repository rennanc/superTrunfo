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
import RxSwift
import RxCocoa
import Firebase
import ObjectMapper

class CardService {
    
    var ref: DatabaseReference!
    
    
    /*
    * Servicos para obter cartas para o jogador
    */
    func getCards(completionHandler: @escaping ([Card], NSError?) -> ()) -> [Card]!{
        
        var cards = [Card]()
        
        /*
        Alamofire.request("https://infnet-ios-api.herokuapp.com/sortDeck").responseArray { (response: DataResponse<[Card]>) in
            
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler([Card](), error as NSError)
            }
        }
        */
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference(withPath: "cards")
        
        ref.observe(.value, with: { snapshot in
            if let jsonArray = snapshot.value as? [[String : AnyObject]]{
                cards = Mapper<Card>().mapArray(JSONArray: jsonArray)
                completionHandler(cards, nil)
            }
            
            
        })
        
        /*
        ref.child("cards").observeSingleEvent(of: .value, with: { (snapshot) in
        
            let values = snapshot.value as? NSDictionary
            let teste =  values?["category"] as? String ?? ""
            //get user value
            //cards = [Card](JSONString: values)!
        }) { (error) in
            print(error.localizedDescription)
        }*/
    
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
        //card.heroImage =  UIImage(named: "add")
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
        
        var mockChallenger : PlayerMove =  PlayerMove();
        mockChallenger.valueSkill = 4
        
        return mockChallenger
    }
    
    func getRooms() -> Observable<String>{
            
        return Observable<String>.create({ (observer) -> Disposable in
            
            let session = URLSession.shared
            let task = session.dataTask(with: URL(string:"https://infnet-ios-api.herokuapp.com/")!) { (data, response, error) in
                
                // We want to update the observer on the UI thread
                DispatchQueue.main.async {
                    if let err = error {
                        // If there's an error, send an Error event and finish the sequence
                        observer.onError(err)
                    } else {
                        if let response = String(data: data!, encoding: .ascii) {
                            //Emit the fetched element
                            observer.onNext(response)
                        } else {
                            //Send error string if we weren't able to parse the response data
                            observer.onNext("Error! Unable to parse the response data from google!")
                        }
                        //Complete the sequence
                        observer.onCompleted()
                    }
                }
            }
            
            task.resume()
            
            //Return an AnonymousDisposable
            return Disposables.create(with: {
                //Cancel the connection if disposed
                task.cancel()
            })
        })
        
        
        
        
        
        /*adicionando dados mockados na celula
        let arrayOfRooms = [
            Room(id: 1, name: "sala 1", challenger: "Joao Almeida", distance: 100,  image: #imageLiteral(resourceName: "room-full")),
            Room(id: 2, name: "sala 2", challenger: "Alberto Martins", distance: 200, image: #imageLiteral(resourceName: "room-empty")),
            Room(id: 3, name: "sala 3", challenger: "Larissa Albuquerque", distance: 300, image: #imageLiteral(resourceName: "room-full")),
        ]
        */
        //return arrayOfRooms
    }
    
    func getRooms2(completionHandler: @escaping ([Room], NSError?) -> ()){
        
        
        
        //criando referencia e referenciando o filho rooms
        ref = Database.database().reference(withPath: "rooms")
        
        ref.observe(.value, with: { snapshot in
            
            var rooms : [Room] = [Room]()
            if let response = snapshot.value as? [String : AnyObject]{
                let allKeys = Array(response.keys)
                
                for key in allKeys {
                    let item = response[key] as! [String: AnyObject]
                    
                    rooms.append(Mapper<Room>().map(JSONObject: item)!)
                }
                completionHandler(rooms, nil)
            }
            
            /*
            if let jsonArray = snapshot.value as? [[String : AnyObject]]{
                
                
                rooms = Mapper<Room>().mapArray(JSONArray: jsonArray)
                completionHandler(rooms, nil)
            }*/
        })
    }
    
    func createRoom (room : Room){
        
        //criando referencia e referenciando o filho rooms
        ref = Database.database().reference(withPath: "rooms")
        
        var newRoom = room
        
        newRoom.id = "1"
        newRoom.available = true
        //newRoom.name="sala" + requestID
        
        //salvando sala
        let JsonString = Mapper().toJSON(newRoom) as [String:AnyObject]
        
        ref.childByAutoId().setValue(JsonString)
    }
    
    
    /*
     * obtem a jogada do desafiante
     */
    func getChalenge() -> Bool{
        /*Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }*/
        
        return true
    }
}
