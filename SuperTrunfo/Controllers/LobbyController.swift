//
//  RoomController.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 28/08/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//  Classe  responsável pelo controle do lobby do jogo mostrando as salas disponíveis
//

import UIKit

class LobbyController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfRooms = [Room]()
    
    @IBOutlet weak var tableRooms: UITableView!
    
    // nome da celula
    let cellRoomId = "RoomCustomCell"
    
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
    
    
    //obtem a sala selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
}
