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

class LobbyController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfRooms = [Room]()
    
    @IBOutlet weak var tableRooms: UITableView!
    
    // nome da celula
    let cellRoomId = "RoomCustomCell"
    
    var playerName = ""
    
    override func viewDidLoad() {
        
        tableRooms.delegate = self
        
        //adicionando dados mockados na celula
        arrayOfRooms = [
            Room(id: 1, name: "sala 1", challenger: "Joao Almeida", distance: 100,  image: #imageLiteral(resourceName: "room-full")),
            Room(id: 2, name: "sala 2", challenger: "Alberto Martins", distance: 200, image: #imageLiteral(resourceName: "room-empty")),
            Room(id: 3, name: "sala 3", challenger: "Larissa Albuquerque", distance: 300, image: #imageLiteral(resourceName: "room-full")),
        ]
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //obtem numero de linhas na table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfRooms.count
    }
    
    // cria uma celula para cada linha do table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //obtendo celula customizada
        let cell = Bundle.main.loadNibNamed(cellRoomId, owner: self, options: nil)?.first as! RoomUITableViewCell
        
        let room = arrayOfRooms[indexPath.row]
        
        //definindo dados da celula
        cell.imageStatus.image = room.image
        cell.nameRoom.text = room.name
        cell.nameChallenger.text = room.challenger
        cell.distance.text =  "" + String(room.distance) + "m de distancia"
        
        return cell
    }
    
    //obtem altura de cada celula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //envia para a sala selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //obtendo a instancia da controller
        let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Room") as! RoomController
        
        //recuperando objeto selecionado
        let room = arrayOfRooms[indexPath.row]
        controllerToSend.navigationItem.prompt = room.name
        
        //entrando na sala escolhida
        navigationController?.pushViewController(controllerToSend, animated: true)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            //obtendo a instancia da controller do Login
            let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginController
            controllerToSend.navigationItem.hidesBackButton = true
            //retornando para a tela de login
            //performSegue(withIdentifier: "segueLogin", sender: self)
            navigationController?.setNavigationBarHidden(true, animated: true)
            navigationController?.pushViewController(controllerToSend, animated: true)
            
            //self.presentingViewController!.dismiss(animated: true, completion: nil)
            
            //self.navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
}
