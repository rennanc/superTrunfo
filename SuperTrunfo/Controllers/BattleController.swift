//
//  BattleController.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 15/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit

class BattleController : UIViewController{
    
    //***Variaveis de tela***
    
    //atributos do desafiante
    @IBOutlet weak var viewCardChallenger: UIView!
    @IBOutlet weak var imageChallenger: UIImageView!
    @IBOutlet weak var labelChallengerNameSkill: UILabel!
    @IBOutlet weak var labelChallengerValueSkill: UILabel!
    
    //atributos do jogador
    @IBOutlet weak var viewCardPlayer: UIView!
    @IBOutlet weak var imagePlayer: UIImageView!
    @IBOutlet weak var labelPlayerNameSkill: UILabel!
    @IBOutlet weak var labelPlayerValueSkill: UILabel!
    
    
    //***Variaveis do modelo***
    
    //atributos do desafiante
    var challengerMove : PlayerMove! = nil
    
    //atributos do jogador deste proprio dispositivo
    var playerMove: PlayerMove! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaultifulLayout()
        
        if playerMove != nil {
            imagePlayer.image = playerMove.image
            labelPlayerNameSkill.text = playerMove.nameSkill
            labelChallengerNameSkill.text = playerMove.nameSkill
            labelPlayerValueSkill.text = String(playerMove.valueSkill)
            
            if(playerMove.valueSkill > challengerMove.valueSkill){
                self.showInfoMessage(title: "Ganhou!!!",message: "Você ganhou essa jogada")
            }else{
                self.showInfoMessage(title: "Perdeu!!!",message: "Você perdeu essa jogada")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //adiciona itens para embelezar o layout
    func beaultifulLayout(){
        //adicionando fundo na view
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image =  UIImage(named: "backgroundMarvel")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let cardImage = UIImageView(frame: self.viewCardChallenger.bounds)
        cardImage.image =  UIImage(named: "cardMarvel")
        self.viewCardChallenger.insertSubview(cardImage, at: 0)
        self.viewCardChallenger.layer.cornerRadius = 10.0
        self.viewCardChallenger.layer.borderWidth = 0.5
        self.viewCardPlayer.insertSubview(cardImage, at: 0)
        self.viewCardPlayer.layer.cornerRadius = 10.0
        self.viewCardPlayer.layer.borderWidth = 0.5
    }
    
}
