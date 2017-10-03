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
    var round : Round = Round()
    
    //atributos do desafiante
    var challengerMove : PlayerMove! = nil
    
    //atributos do jogador deste proprio dispositivo
    var playerMove: PlayerMove! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assumindo a responsabilidade do navigation controller
        navigationController?.delegate = self
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Voltar", style: .plain, target: self, action: #selector(backAction))
        
        beaultifulLayout()
        
        if playerMove != nil {
            imagePlayer.image = playerMove.image
            labelPlayerNameSkill.text = round.nameSkill
            labelPlayerValueSkill.text = String(playerMove.valueSkill)
            
            imageChallenger.image = challengerMove.image
            labelChallengerNameSkill.text = round.nameSkill
            labelChallengerValueSkill.text = String(playerMove.valueSkill)
            
            if(playerMove.valueSkill > challengerMove.valueSkill){
                self.showInfoMessage(title: "Ganhou!!!",message: "Você ganhou essa jogada")
            }else if(playerMove.valueSkill < challengerMove.valueSkill){
                self.showInfoMessage(title: "Perdeu!!!",message: "Você perdeu essa jogada")
            }else{
                self.showInfoMessage(title: "Empate!!!",message: "Vocês empataram, os 2 perderam")
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
        
        let cardImage2 = UIImageView(frame: self.viewCardPlayer.bounds)
        cardImage2.image =  UIImage(named: "cardMarvel")
        self.viewCardPlayer.insertSubview(cardImage2, at: 0)
        self.viewCardPlayer.layer.cornerRadius = 10.0
        self.viewCardPlayer.layer.borderWidth = 0.5
    }
    
    //voltar para a sala
    @IBAction func backButtonToRoom(_ sender: Any) {
        performSegue(withIdentifier: "Room", sender: nil)
    }
    
    
}

extension BattleController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        var battleStatus : BattleStatus = BattleStatus.draw
        if(playerMove.valueSkill > challengerMove.valueSkill){
            battleStatus = BattleStatus.win
        }else if(playerMove.valueSkill < challengerMove.valueSkill){
            battleStatus = BattleStatus.defeat
        }
        
        (viewController as? RoomController)?.receiveResult(battleStatus: battleStatus, resultGame: round);
    }
}
