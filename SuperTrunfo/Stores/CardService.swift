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
    func getCards(completionHandler: @escaping ([Card], NSError?) -> ()){
        
        //obtendo por servico da api via rest
        Alamofire.request("https://infnet-ios-api.herokuapp.com/sortDeck").responseArray { (response: DataResponse<[Card]>) in
            
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler([Card](), error as NSError)
            }
        }
        
        //obtendo por firebase database
        /*
        var ref: DatabaseReference!
        
        ref = Database.database().reference(withPath: "cards")
        
        ref.observe(.value, with: { snapshot in
            if let jsonArray = snapshot.value as? [[String : AnyObject]]{
                cards = Mapper<Card>().mapArray(JSONArray: jsonArray)
                completionHandler(cards, nil)
            }
            
            
        })
        */
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
        })
    }
    
    func createRoom (room : Room){
        /*
        let params : String =  room.toJSONString(prettyPrint: true)!
        
        let teste : Parameters = Parameters()
        */
        /*
        Alamofire.request("https://infnet-ios-api.herokuapp.com/createRoom", method: .put, parameters: params, encoding: JSONEncoding.default).responseObject(keyPath: "room") { (response: DataResponse<Room>) in
            
            switch response.result {
            case .success(let value): break
                //completionHandler(value, nil)
            case .failure(let error): break
                //completionHandler([Card](), error as NSError)
            }
        }
        
        */
        
        
        
        //criando referencia e referenciando o filho rooms
        ref = Database.database().reference(withPath: "rooms")
        
        var newRoom = room
        
        let requestID = ref.childByAutoId().key
        
        newRoom.id = requestID
        newRoom.available = true
        var round : Round = Round()
        round.number = 1
        newRoom.rounds.append(round)
        //newRoom.name="sala" + requestID
        
        //salvando sala
        let JsonString = Mapper().toJSON(newRoom) as [String:AnyObject]
        
        ref.child(requestID).setValue(JsonString)
        //ref.childByAutoId().setValue(JsonString)
        
    }
    
    
    /*
     * obtem a jogada do desafiante
     */
    func joinRoom(roomId: String, playerName: String) -> Bool{
        
        var player : Player = Player()
        player.name = playerName
        
        let JsonString = Mapper().toJSON(player) as [String:AnyObject]
        
        //criando referencia e referenciando o filho rooms
        ref = Database.database().reference(withPath: "rooms/" + roomId + "/players")
        
        ref.child(String(1)).setValue(JsonString)
        //ref.childByAutoId().setValue(JsonString)
        
        return true
    }
    
    func waitChallenger(completionHandler: @escaping ([Player], NSError?) -> (), roomId: String, playerName: String){
        
        //criando referencia para escutar a sala
        ref = Database.database().reference(withPath: "rooms/" + roomId )
        
        ref.observe(.value, with: { snapshot in
            
            let value =  snapshot.value as? [String : AnyObject]
            let room = Mapper<Room>().map(JSONObject: value)!
            completionHandler(room.players, nil)
        })
    }
    
    
    //salva as cartas do jogador
    func savePlayerCards(roomId: String, playerName: String, playerId: String, cards: [Card]){
    
        var player : Player = Player()
        player.name = playerName
        
        for card in cards {
            player.cardsId.append(card.id)
        }
        
        let JsonString = Mapper().toJSON(player) as [String:AnyObject]
        
        //criando referencia e referenciando o filho rooms
        ref = Database.database().reference(withPath: "rooms/" + roomId + "/players/")
        
        ref.child(playerId).setValue(JsonString)
    }
    
    //obtem as cartas dos jogadores
    func getPlayerCards(roomId: String, playerName: String) -> Bool{
        
        var player : Player = Player()
        player.name = playerName
        
        let JsonString = Mapper().toJSON(player) as [String:AnyObject]
        
        //criando referencia e referenciando o filho rooms
        ref = Database.database().reference(withPath: "rooms/" + roomId + "/players")
        
        ref.childByAutoId().setValue(JsonString)
        
        return true
    }
    
    /*
     * obtem a jogada do desafiante
     */
    func createRound(roomId: String, roundId: Int, playerMove: PlayerMove, playerName: String) -> Round{
        
        var round : Round = Round()
        round.number = roundId
        round.nameSkill = playerMove.nameSkill
        round.playerMoves.append(playerMove)
        
        let JsonString = Mapper().toJSON(round) as [String:AnyObject]
        
        //criando referencia e referenciando o filho rooms
        ref = Database.database().reference(withPath: "rooms/" + roomId)
        
        ref.child("rounds").childByAutoId().setValue(JsonString)
        
        return round
    }
    
    
    func waitChangeRounds(completionHandler: @escaping ([Round], NSError?) -> (), roomId: String){
        
        //criando referencia para escutar a sala
        ref = Database.database().reference(withPath: "rooms/" + roomId + "/rounds")
        
        ref.observe(.value, with: { snapshot in
            
            var rounds : [Round] = [Round]()
            if let response = snapshot.value as? [String : AnyObject]{
                let allKeys = Array(response.keys)
                
                for key in allKeys {
                    let item = response[key] as! [String: AnyObject]
                    
                    rounds.append(Mapper<Round>().map(JSONObject: item)!)
                }
                completionHandler(rounds, nil)
            }
        })
    }
}
