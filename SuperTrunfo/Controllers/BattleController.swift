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
    @IBOutlet weak var imageChallenger: UIImageView!
    @IBOutlet weak var labelChallengerNameSkill: UILabel!
    @IBOutlet weak var labelChallengerValueSkill: UILabel!
    
    //atributos do jogador
    @IBOutlet weak var imagePlayer: UIImageView!
    @IBOutlet weak var labelPlayerNameSkill: UILabel!
    @IBOutlet weak var labelPlayerValueSkill: UILabel!
    
    
    //***Variaveis do modelo***
    
    //atributos do desafiante
    let challengerMove : PlayerMove! = nil
    
    //atributos do jogador deste proprio dispositivo
    var playerMove: PlayerMove! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if playerMove != nil {
            imagePlayer.image = playerMove.image
            labelPlayerNameSkill.text = playerMove.nameSkill
            labelPlayerValueSkill.text = playerMove.valueSkill
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
