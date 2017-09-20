//
//  RoomController.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 14/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit

class RoomController : UIViewController{
    
    //*** itens de tela da carta ***
    @IBOutlet weak var labelHeroName: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    
    //nome das habilidades
    
    @IBOutlet weak var labelSkill1: UILabel!
    @IBOutlet weak var labelSkill2: UILabel!
    @IBOutlet weak var labelSkill3: UILabel!
    @IBOutlet weak var labelSkill4: UILabel!
    
    var listOfSkillsName = [UILabel]() //lista de nomes
    
    //valor das habilidades
    @IBOutlet weak var labelSkillValue1: UILabel!
    @IBOutlet weak var labelSkillValue2: UILabel!
    @IBOutlet weak var labelSkillValue3: UILabel!
    @IBOutlet weak var labelSkillValue4: UILabel!
    
    var listOfSkillsValue = [UILabel]() //lista de valores
    
    //imagem de outras cartas na mao do jogador
    @IBOutlet weak var imageCard1: UIImageView!
    @IBOutlet weak var imageCard2: UIImageView!
    @IBOutlet weak var imageCard3: UIImageView!
    @IBOutlet weak var imageCard4: UIImageView!
    @IBOutlet weak var imageCard5: UIImageView!
    @IBOutlet weak var imageCard6: UIImageView!
    
    
    //*** itens de tela do jogador ***
    @IBOutlet weak var labelNumberOfCards: UILabel!
    @IBOutlet weak var labelNumCardsInDeck: UILabel!
    
    @IBOutlet weak var labelNumWinner: UILabel!
    @IBOutlet weak var labelNumDefeat: UILabel!
    
    
    //*** servicos ***
    var cardService : CardService = CardService()
    
    //*** modelos ***
    var playerMove : PlayerMove!
    var cards : [Card] = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkillsTapGesture()
        
        showCards()
        
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
                                     labelSkill4)
        
        //lista de valores
        listOfSkillsValue = [UILabel](arrayLiteral: labelSkillValue1,
                                      labelSkillValue2,
                                      labelSkillValue3,
                                      labelSkillValue4)
        
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
    
    func showCards(){
        //carregando as cartas pela primeira vez
        var cards = cardService.getCards()
        
        if !cards.isEmpty {
            //exibe a primeira carta selecionada por padrao
            showCard(card: cards[0])
            
            //exibe a miniatura das outras cartas na mao do jogador
            imageCard1.image = cards[1].heroImage
            imageCard2.image = cards[2].heroImage
            imageCard3.image = cards[3].heroImage
            imageCard4.image = cards[5].heroImage
            imageCard5.image = cards[6].heroImage
            imageCard6.image = cards[7].heroImage
        }else{
            //TODO ALERT
        }
        
    }
    
    func showCard(card : Card){
        labelHeroName.text = card.heroName
        imageHero.image = card.heroImage
        labelSkillValue1.text = String(card.skillValue1)
        labelSkillValue2.text = String(card.skillValue2)
        labelSkillValue3.text = String(card.skillValue3)
        labelSkillValue4.text = String(card.skillValue4)
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
        
        let challengerMove = cardService.getChallengerMove();
        
        //obtendo a instancia da controller
        let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Battle") as! BattleController
        
        //transferindo objeto para a nova pagina
        controllerToSend.playerMove = playerMove
        controllerToSend.challengerMove = challengerMove
        
        //enviando o usuario para a pagina da batalha
        navigationController?.pushViewController(controllerToSend, animated: true)
    }
    
    
    
}
