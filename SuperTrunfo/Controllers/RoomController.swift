//
//  RoomController.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 14/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit

class RoomController : UIViewController{
    
    @IBOutlet weak var cardView: UIView!
    
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
    
    var listImageCardsInHands = [UIImageView]() //lista de imagens de cartas na mao
    
    
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
    var cardsPlayer : [Card] = [Card]()
    var cardsChallenger : [Card] = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaultifulLayout()
        
        setupSkillsTapGesture()
        setupCardsTapGesture()
        showCards()
        
        startGame()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //adiciona itens para embelezar o leyout
    func beaultifulLayout(){
        //adicionando fundo na view
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image =  UIImage(named: "backgroundMarvel")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let cardImage = UIImageView(frame: self.cardView.bounds)
        cardImage.image =  UIImage(named: "cardMarvel")
        //cardImage.wid
        //cardImage.contentMode = UIViewContentMode.s
        self.cardView.insertSubview(cardImage, at: 0)
        self.cardView.layer.cornerRadius = 10.0
        self.cardView.layer.borderWidth = 0.5
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
    
    //definindo gesto para adicionar acao as imagens para troca
    func setupCardsTapGesture(){
        listImageCardsInHands = [UIImageView](arrayLiteral: imageCard1,
                                              imageCard2,
                                              imageCard3,
                                              imageCard4,
                                              imageCard5,
                                              imageCard6)
        
        for imageCardInHands in listImageCardsInHands{
            let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(self.selectCard))
            tapGesture.isEnabled = true
            imageCardInHands.addGestureRecognizer(tapGesture)
        }
    }
    
    //obtem todos as cartas do jogador
    func showCards(){
        //carregando as cartas pela primeira vez
       // cards = cardService.getCards(completionHandler: nil)
        cardService.getCards { responseObject, error in
            self.buildPlayerDeck(cards: responseObject)
            
        }
    }
    
    
    func buildPlayerDeck(cards : [Card]){
        if !cards.isEmpty {
            
            //gravando cartas na memoria
            self.cards = cards
            
            //define a primeira vez quantas cartas possui inicialmente
            labelNumberOfCards.text = String(cards.count - 1)
            
            //exibe a primeira carta selecionada por padrao
            showCard(card: cards[0])
            
            //exibe a miniatura das outras cartas na mao do jogador
            imageCard1.image = getImageFromUrl(imageUrl: cards[1].heroImage)
            imageCard2.image = getImageFromUrl(imageUrl: cards[2].heroImage)
            imageCard3.image = getImageFromUrl(imageUrl: cards[3].heroImage)
            imageCard4.image = getImageFromUrl(imageUrl: cards[5].heroImage)
            imageCard5.image = getImageFromUrl(imageUrl: cards[6].heroImage)
            imageCard6.image = getImageFromUrl(imageUrl: cards[7].heroImage)
        }else{
            showErrorMessage(message: "Ocorreu um erro ao obter as cartas, saia do jogo e tente novamente.")
        }
    }
    
    //TODO COLOCAR EM UM UTIL
    func getImageFromUrl(imageUrl : String) -> UIImage{
        if imageUrl != "" {
            let url = URL(string: imageUrl)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image : UIImage = UIImage(data: imageData)!
                return image
            }
        }
        return UIImage()
    }
    
    //mostra a carta selecionada em evidencia
    func showCard(card : Card){
        labelHeroName.text = card.heroName
        imageHero.image = getImageFromUrl(imageUrl: card.heroImage)
        labelSkillValue1.text = String(card.skillValue1)
        labelSkillValue2.text = String(card.skillValue2)
        labelSkillValue3.text = String(card.skillValue3)
        labelSkillValue4.text = String(card.skillValue4)
    }
    
    //acao de selecionar carta para trocar a carta na mao para colocar ela em evidencia
    func selectCard(sender: UITapGestureRecognizer) {
        //obtendo view
        let selectedView : UIView = sender.view!
        
        //obtendo o card exibido
        let cardShowed = cards[0]
        
        //obtem a carta selecionada
        let selectedCard = cards[selectedView.tag]
        //troca a carta exibida pela a selecionada na tela
        showCard(card: selectedCard)
        
        //troca a ordem da carta mostrada pela carta selecionada no array
        cards[0] = selectedCard
        cards[selectedView.tag] = cardShowed
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
        playerMove.valueSkill = Int(selectedLabel.text!)
        
        //obtendo o nome do item selecionado
        if let i = listOfSkillsName.index(where: { $0.tag == selectedLabel.tag}){
            playerMove.nameSkill = listOfSkillsName[i].text!
        }
        
        showMessageBeforeMove(playerMove: playerMove)
    }
    
    
    
    //Envia a habilidade selecionada para a tela de batalha para obter o resultado da disputa
    func sendToBattlePage(playerMove : PlayerMove){
        
        //obtendo resultado da jogada
        let challengerMove = cardService.getChallengerMove();
        
        //obtendo a instancia da controller
        let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Battle") as! BattleController
        
        //transferindo objeto para a nova pagina
        controllerToSend.playerMove = playerMove
        controllerToSend.challengerMove = challengerMove
        
        //enviando o usuario para a pagina da batalha
        navigationController?.pushViewController(controllerToSend, animated: true)
    }
    
    /*verifica se o jogador é o desafiante ou nao
    * e mostra as instrucoes para seguir
    */
    func startGame(){
        let challenge = cardService.getChalenge()
        if(challenge){
            self.showInfoMessage(message: "Você é o desafiante, a partida começa por você.\n Escolha uma carta entre as 7 e entao, escolha a melhor Habilidade clicando sobre elas.")
        }else{
            self.showInfoMessage(message: "Você foi desafiado, aguarde o seu desafiante escolher uma carta")
        }
    }
    
    func receiveResult(result : Int){
        self.showInfoMessage(message: "retorno" + String(result))
    }
    
    
    //exibe confirmacao antes de enviar o movimento
    func showMessageBeforeMove(playerMove : PlayerMove){
        //Mostrar
        let alert = UIAlertController(title: "Confirmacao", message: "Você escolheu a habilidade de " + playerMove.nameSkill, preferredStyle: UIAlertControllerStyle.alert)
        
        //adicionando opçoes no alerta
        alert.addAction(UIAlertAction(title: "Enviar", style: UIAlertActionStyle.default, handler: { action in self.sendToBattlePage(playerMove: playerMove) } ))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil ))
        
        //exibir alerta tela na tela atual
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
