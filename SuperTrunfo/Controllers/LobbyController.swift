//
//  RoomController.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 28/08/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//  Classe  responsável pelo controle do lobby do jogo mostrando as salas disponíveis
//

import UIKit
import Firebase
import RxCocoa
import RxSwift
import ObjectMapper
import CoreLocation

class LobbyController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfRooms = [Room]()
    
    @IBOutlet weak var tableRooms: UITableView!
    
    //*** servicos ***
    var cardService : CardService = CardService()
    
    let disposeBag = DisposeBag()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    // nome da celula
    let cellRoomId = "RoomCustomCell"
    
    var playerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        //delegando essa view para controlar a tabela
        tableRooms.delegate = self
        setupLobby()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupLobby(){
        navigationItem.prompt = playerName
        
        //solicitando permissao para acesso ao gps
        locManager.requestWhenInUseAuthorization()
        
        
        cardService.getRooms2 { responseObject, error in
            self.arrayOfRooms = responseObject
            self.tableRooms.reloadData()
        }
        
        //Remember about [weak self]/[unowned self] to prevent retain cycles!
        /*cardService.getRooms()
         .subscribe(onNext: { [weak self] (element) in
         self?.arrayOfRooms = [Room](JSONString: element)!
         self?.tableRooms.reloadData()
         }).addDisposableTo(disposeBag)*/
        //arrayOfRooms =
    }
    
    @IBAction func createRoom(_ sender: Any){
        var newRoom = Room()
        newRoom.creator = playerName
        currentLocation = locManager.location
        newRoom.latitude = currentLocation.coordinate.latitude
        newRoom.longitude = currentLocation.coordinate.longitude
        var player : Player = Player()
        player.name = playerName
        newRoom.players.append(player)
        
        cardService.createRoom(room: newRoom)
    }
    
    
    //obtem localizacao do usuario
    func getDistanceOfPlayers(challengerLatitude : Double, challengerLongitude : Double) -> Double!{
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            
            //obtendo distancia do desafiante de acordo com a localizacao do jogador
            let coordinateChallenger = CLLocation(latitude: challengerLatitude, longitude: challengerLongitude)
            let coordinatePlayer = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            return coordinateChallenger.distance(from: coordinatePlayer) // resultado em metros
        }
        return nil
    }
    
    
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            performSegue(withIdentifier: "segueLogin", sender: self)
            /*
            //obtendo a instancia da controller do Login
            let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginController
            controllerToSend.navigationItem.hidesBackButton = true
            //retornando para a tela de login
            navigationController?.setNavigationBarHidden(true, animated: true)
            navigationController?.pushViewController(controllerToSend, animated: true)*/
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    //********** Controle da tabela  *********
    
    
    //obtem numero de linhas na table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfRooms.count
    }
    
    // cria uma celula para cada linha do table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //obtendo celula customizada
        let cell = Bundle.main.loadNibNamed(cellRoomId, owner: self, options: nil)?.first as! RoomUITableViewCell
        
        var room = arrayOfRooms[indexPath.row]
        
        //definindo dados da celula
        
        if(room.available){
            cell.imageStatus.image = UIImage(named: "room-empty")
        }else{
            cell.imageStatus.image = UIImage(named: "room-full")

        }
        
        //cell.nameRoom.text = room.name
        cell.nameChallenger.text = room.creator
        
        room.distance = getDistanceOfPlayers(challengerLatitude: room.latitude, challengerLongitude: room.longitude)
        
        if(room.distance != nil){
            cell.distance.text =  "" + String(room.distance) + " m de distancia"
        }
        
        return cell
    }
    
    //obtem altura de cada celula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    //envia para a sala selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //obtendo a instancia da controller
        let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Room") as! RoomController
        
        //recuperando objeto selecionado
        let room = arrayOfRooms[indexPath.row]
        controllerToSend.navigationItem.prompt = room.name
        controllerToSend.room = room
        controllerToSend.playerName = playerName
        
        //entrando na sala escolhida
        navigationController?.pushViewController(controllerToSend, animated: true)
    }
    
}
