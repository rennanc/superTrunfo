//
//  RoomController.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 14/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit

class RoomController : UIViewController{
    
    
    //itens de tela da carta
    @IBOutlet weak var labelHeroName: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    
    //nome das habilidades
    var listOfSkillsName = [UILabel]() //lista de nomes
    
    @IBOutlet weak var labelSkill1: UILabel!
    @IBOutlet weak var labelSkill2: UILabel!
    @IBOutlet weak var labelSkill3: UILabel!
    @IBOutlet weak var labelSkill4: UILabel!
    @IBOutlet weak var labelSkill5: UILabel!
    
    //valor das habilidades
    var listOfSkillsValue = [UILabel]() //lista de valores
    
    @IBOutlet weak var labelSkillValue1: UILabel!
    @IBOutlet weak var labelSkillValue2: UILabel!
    @IBOutlet weak var labelSkillValue3: UILabel!
    @IBOutlet weak var labelSkillValue4: UILabel!
    @IBOutlet weak var labelSkillValue5: UILabel!
    
    
    //itens de tela do jogador
    @IBOutlet weak var labelNumberOfCards: UILabel!
    @IBOutlet weak var labelNumCardsInDeck: UILabel!
    
    @IBOutlet weak var labelNumWinner: UILabel!
    @IBOutlet weak var labelNumDefeat: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkillsTapGesture()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     *  configura acoes de gesto para as labels de skill tanto
     *  para nomes quanto para valores
     */
    func setupSkillsTapGesture(){
        
        var listOfSkills = [UILabel]() // lista com nomes e valores
        
        //atribuindo as listas de nomes quanto de valores para receber o evento
        listOfSkills.append(contentsOf: listOfSkillsName)
        listOfSkills.append(contentsOf: listOfSkillsValue)
        
        for labelSkill in listOfSkills{
            let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(self.selectSkill))
            tapGesture.isEnabled = true
            labelSkill.addGestureRecognizer(tapGesture)
        }
    }
    
    //escolher skill, será definido qual é pela tag
    func selectSkill(sender: UITapGestureRecognizer){
        let selectedView : UIView = sender.view!
        
        let selectedLabel : UILabel = selectedView.viewWithTag(selectedView.tag) as! UILabel
        
        
        let alert = UIAlertController(title: "Confirmacao", message: "Você escolheu a habilidade de " + String(describing: selectedLabel.text), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        sendToBattlePage()
        print("tap funcionando. tag: " + String(selectedLabel.tag))
    }
    
    //Envia a habilidade selecionada para a tela de batalha para obter o resultado da disputa
    func sendToBattlePage(){
        //obtendo a instancia da controller
        let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Battle") as! BattleController
        
        //recuperando objeto selecionado
        //let room = arrayOfRooms[indexPath.row]
        //controllerToSend.navigationItem.prompt = room.name
        
        //entrando na sala escolhida
        navigationController?.pushViewController(controllerToSend, animated: true)
    }
    
    
    
}
