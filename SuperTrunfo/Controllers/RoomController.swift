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
    
    @IBOutlet weak var labelSkill1: UILabel!
    @IBOutlet weak var labelSkill2: UILabel!
    @IBOutlet weak var labelSkill3: UILabel!
    @IBOutlet weak var labelSkill4: UILabel!
    @IBOutlet weak var labelSkill5: UILabel!
    
    var listOfSkillsName = [UILabel]() //lista de nomes
    
    //valor das habilidades
    @IBOutlet weak var labelSkillValue1: UILabel!
    @IBOutlet weak var labelSkillValue2: UILabel!
    @IBOutlet weak var labelSkillValue3: UILabel!
    @IBOutlet weak var labelSkillValue4: UILabel!
    @IBOutlet weak var labelSkillValue5: UILabel!
    
    var listOfSkillsValue = [UILabel]() //lista de valores
    
    
    //itens de tela do jogador
    @IBOutlet weak var labelNumberOfCards: UILabel!
    @IBOutlet weak var labelNumCardsInDeck: UILabel!
    
    @IBOutlet weak var labelNumWinner: UILabel!
    @IBOutlet weak var labelNumDefeat: UILabel!
    
    
    //servicos
    var cardService : CardService? = nil
    
    //modelos
    var playerMove : PlayerMove!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkillsTapGesture()
        cardService?.getCards()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     *  configura acoes de gesto para as labels de skill tanto
     *  para nomes quanto para valores
     */
    func setupSkillsTapGesture(){
        
        //lista de nomes
        listOfSkillsName = [UILabel](arrayLiteral: labelSkill1,
                                     labelSkill2,
                                     labelSkill3,
                                     labelSkill4,
                                     labelSkill5)
        
        //lista de valores
        listOfSkillsValue = [UILabel](arrayLiteral: labelSkillValue1,
                                      labelSkillValue2,
                                      labelSkillValue3,
                                      labelSkillValue4,
                                      labelSkillValue5)
        
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
        
        //obtendo view
        let selectedView : UIView = sender.view!
        //obtendo label da view com a tag
        let selectedLabel : UILabel = selectedView.viewWithTag(selectedView.tag) as! UILabel
        
        //criando uma nova instancia
        playerMove = PlayerMove()
        //salvando imagem
        playerMove.image = imageHero.image
        
        //salvando o valor do item selecionado
        playerMove.valueSkill = selectedLabel.text
        
        //obtendo o nome do item selecionado
        if let i = listOfSkillsName.index(where: { $0.tag == selectedLabel.tag}){
            playerMove.nameSkill = listOfSkillsName[i].text!
        }
        
        showMessageBeforeMove(playerMove: playerMove)
    }
    
    //exibe confirmacao antes de enviar o movimento
    func showMessageBeforeMove(playerMove : PlayerMove){
        //Mostrar
        let alert = UIAlertController(title: "Confirmacao", message: "Você escolheu a habilidade de " + playerMove.nameSkill, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Enviar", style: UIAlertActionStyle.default, handler: { action in self.sendToBattlePage(playerMove: playerMove) } ))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil ))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Envia a habilidade selecionada para a tela de batalha para obter o resultado da disputa
    func sendToBattlePage(playerMove : PlayerMove){
        
        //obtendo a instancia da controller
        let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Battle") as! BattleController
        
        controllerToSend.playerMove = playerMove
        
        //enviando o usuario para a pagina da batalha
        navigationController?.pushViewController(controllerToSend, animated: true)
    }
    
    
    
}
