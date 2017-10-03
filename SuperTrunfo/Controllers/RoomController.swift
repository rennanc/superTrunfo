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
    var playerName : String = ""
    var playerPanel : Panel! = Panel()
    var playerMove : PlayerMove!
    var cards : [Card] = [Card]()
    var cardsPlayer : [Card] = [Card]()
    var cardsChallenger : [Card] = [Card]()
    var room : Room = Room()
    var isChallenger = false
    var lastRound : Round = Round()
    var isMyTurn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.prompt = nil
        
        // verifica se é o desafiante
        if(room.creator != playerName){
            isChallenger = true
            isMyTurn = true
        }
        
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
        listImageCardsInHands = [UIImageView](arrayLiteral: imageHero, imageCard1,
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
        cardService.getCards { responseObject, error in
            self.buildPlayerDeck(cards: responseObject)
            
        }
    }
    
    
    func buildPlayerDeck(cards : [Card]){
        if !cards.isEmpty {
            
            //gravando cartas na memoria
            self.cards = cards
            
            
            //lista de cartas temporaria
            var cardsTemp : [Card] = [Card]()
            //pega 15 cartas e atribui para o jogador
            if(!isChallenger){
                let arraySlice = cards[0...14]
                cardsPlayer = Array(arraySlice)
                cardsTemp = cardsPlayer
                //salva as cartas do jogador(criador da partida) no firebase
                cardService.savePlayerCards(roomId: room.id, playerName: playerName, playerId: String(0), cards: cardsPlayer)
            }else{
                let arraySlice2 = cards[15...29]
                cardsChallenger = Array(arraySlice2)
                cardsTemp = cardsChallenger
                //salva as cartas do desafiante no firebase
                cardService.savePlayerCards(roomId: room.id, playerName: playerName, playerId: String(1), cards: cardsChallenger)
            }
            
            //define a primeira vez quantas cartas possui inicialmente
            playerPanel.numberOfCards = cardsTemp.count
            playerPanel.numberCardInDeck = cards.count
            refreshPlayerPanel()
            
            //exibe a primeira carta selecionada por padrao
            showCard(card: cardsTemp[0])
            
            //exibe a miniatura das outras cartas na mao do jogador
            imageCard1.image = getImageFromUrl(imageUrl: cardsTemp[1].heroImage)
            imageCard2.image = getImageFromUrl(imageUrl: cardsTemp[2].heroImage)
            imageCard3.image = getImageFromUrl(imageUrl: cardsTemp[3].heroImage)
            imageCard4.image = getImageFromUrl(imageUrl: cardsTemp[5].heroImage)
            imageCard5.image = getImageFromUrl(imageUrl: cardsTemp[6].heroImage)
            imageCard6.image = getImageFromUrl(imageUrl: cardsTemp[7].heroImage)
            
            
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
        labelHeroName.text = card.category + String(card.rank) + " - " + card.heroName
        imageHero.image = getImageFromUrl(imageUrl: card.heroImage)
        labelSkillValue1.text = String(card.skillValue1)
        labelSkillValue2.text = String(card.skillValue2)
        labelSkillValue3.text = String(card.skillValue3)
        labelSkillValue4.text = String(card.skillValue4)
    }
    
    //acao de selecionar carta para trocar a carta na mao para colocar ela em evidencia
    func selectCard(sender: UITapGestureRecognizer) {
        var cardsTemp : [Card] = [Card]()
        if(isChallenger){
            cardsTemp = cardsChallenger
        }else{
            cardsTemp = cardsPlayer
        }
        
        
        //obtendo view
        let selectedView : UIView = sender.view!
        
        //obtendo o card exibido
        let cardShowed = cardsTemp[0]
        
        //obtem a carta selecionada
        let selectedCard = cardsTemp[selectedView.tag]
        
        let imageViewSelected : UIImageView = listImageCardsInHands[selectedView.tag]
        
        //troca a carta exibida pela a selecionada na tela
        showCard(card: selectedCard)
        
        //troca a ordem da carta mostrada pela carta selecionada no array
        cardsTemp[0] = selectedCard
        
        cardsTemp[selectedView.tag] = cardShowed
        
        if(isChallenger){
            cardsChallenger = cardsTemp
        }else{
            cardsPlayer = cardsTemp
        }
        
        imageViewSelected.image = getImageFromUrl(imageUrl: cardShowed.heroImage)
        
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
        playerMove.player.name = playerName
        
        
        var cardsTemp : [Card] = [Card]()
        if(isChallenger){
            cardsTemp = cardsChallenger
        }else{
            cardsTemp = cardsPlayer
        }
        
        playerMove.cardId = String(cardsTemp[0].id)
        
        //salvando o valor do item selecionado
        playerMove.valueSkill = Int(selectedLabel.text!)
        
        //obtendo o nome do item selecionado
        if let i = listOfSkillsName.index(where: { $0.tag == selectedLabel.tag}){
            playerMove.nameSkill = listOfSkillsName[i].text!
        }
        showMessageBeforeMove(playerMove: playerMove)
    }
    
    
    
    
    
    /*verifica se o jogador é o desafiante ou nao
    * e mostra as instrucoes para seguir
    */
    func startGame(){
        
        if(isChallenger){
            isMyTurn = true
            //inserir usuario na sala
            cardService.joinRoom(roomId: room.id, playerName: playerName)
            self.showInfoMessage(message: "Você é o desafiante, a partida começa por você.\n Escolha uma carta entre as 7 e entao, escolha a melhor Habilidade clicando sobre elas.")
            
            
        }else{
            isMyTurn = false
            //adiciona canal para ficar escutando a notificacao quando o adversario entrar na sala
            cardService.waitChallenger(completionHandler: { responseObject, error in
                if(responseObject.count > 1){
                    self.showInfoMessage(message: "Você foi desafiado por " + responseObject[1].name + ", aguarde o seu desafiante escolher uma carta")
                }
            }, roomId: room.id, playerName: room.creator)
            
            
            cardService.waitChangeRounds(completionHandler: { responseObject, error in
                if(responseObject.count > 0){
                    if(responseObject.last?.number == self.lastRound.number){
                        self.showInfoMessage(message: "O Jogador adversario fez a jogada. Ele escolheu o atributo:" + (responseObject.last?.nameSkill)! + ". Escolha sua melhor carta com esse atributo")
                    }
                    
                }
            }, roomId: room.id)
        }
    }
    
    /*Funcao para receber resultado da jogada enviada pela tela de 
     *batalha
     */
    func receiveResult(battleStatus : BattleStatus, resultGame: Round){
        
        if(battleStatus == BattleStatus.win){
            playerPanel.numberWinners = playerPanel.numberWinners + 1
            playerPanel.numberOfCards = playerPanel.numberOfCards + 1
        }else if(battleStatus == BattleStatus.defeat){
            playerPanel.numberDefeats = playerPanel.numberDefeats + 1
            playerPanel.numberOfCards = playerPanel.numberOfCards - 1
        }else{ //empate
            playerPanel.numberOfCards = playerPanel.numberOfCards - 1
        }
        
        refreshPlayerPanel()
        //TODO
        //cardService.gravarResultado()
        checkFinalResult()
    }
    
    func changeOrderOfDeck(){
        
        //var firstCard
    }
    
    func refreshPlayerPanel(){
        labelNumWinner.text = String(playerPanel.numberWinners)
        labelNumDefeat.text = String(playerPanel.numberDefeats)
        labelNumberOfCards.text =  String(playerPanel.numberOfCards)
        labelNumCardsInDeck.text = String(playerPanel.numberCardInDeck)
    }
    
    //verifica se a partida chegou ao fim
    func checkFinalResult(){
        if(playerPanel.numberOfCards == 0){
            showInfoMessage(message: "Fim de Partida, você perdeu")
        }else if(playerPanel.numberOfCards == 32){
            showInfoMessage(message: "Fim de Partida, você ganhou")
        }
        //TODO fechar sala
        //cardService.closeRoom(roomId)
        //TODO
        //voltar para o lobby
    }
    
    
    //exibe confirmacao antes de enviar o movimento
    func showMessageBeforeMove(playerMove : PlayerMove){
        //Mostrar
        let alert = UIAlertController(title: "Confirmacao", message: "Você escolheu a habilidade de " + playerMove.nameSkill, preferredStyle: UIAlertControllerStyle.alert)
        
        //adicionando opçoes no alerta
        alert.addAction(UIAlertAction(title: "Enviar", style: UIAlertActionStyle.default, handler: { action in
            
            
            if(self.isChallenger && self.lastRound.number == 0){
                self.lastRound = self.cardService.createRound(roomId: self.room.id, roundId: 1, playerMove: playerMove, playerName: self.playerName)
            }else{
                //verifica se for o turno da vez para criar a partida
                if(self.isMyTurn){
                    let roundId = self.lastRound.number + 1
                    self.lastRound = self.cardService.createRound(roomId: self.room.id, roundId: roundId, playerMove: playerMove, playerName: self.playerName)
                }
            }
            
            //escutar o round para esperar o outro jogador fazer a jogada
            self.cardService.waitChangeRounds(completionHandler: { responseObject, error in
                if(responseObject.count > 0){
                    let lastRound = responseObject[responseObject.endIndex - 1]
                    let lastPlayerMove = lastRound.playerMoves[lastRound.playerMoves.endIndex - 1]
                    
                    if(lastPlayerMove.player.name == self.playerName){
                        self.showInfoMessage(message: "Aguarde a jogada do outro jogador")
                    }else{
                        self.sendToBattlePage(round: (responseObject.last)!)
                    }
                    
                }
            }, roomId: self.room.id)
            
            
            
            
        } ))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil ))
        
        //exibir alerta tela na tela atual
        self.present(alert, animated: true, completion: nil)
    }
    
    //Envia a habilidade selecionada para a tela de batalha para obter o resultado da disputa
    func sendToBattlePage(round : Round){
        
        //obtendo resultado da jogada
        //let challengerMove = cardService.getChallengerMove();
        
        //obtendo a instancia da controller
        let controllerToSend = storyboard?.instantiateViewController(withIdentifier: "Battle") as! BattleController
        
        
        //TODO criacao de nova partida
        //cardService.createGame()
        //roundTemp.playerMoves.append(playerMove)
        //roundTemp.playerMoves.append(challengerMove)
        
        controllerToSend.round = round
        
        //transferindo objeto para a nova pagina
        if(round.playerMoves[0].player.name == playerName){
            controllerToSend.playerMove = round.playerMoves[0]
            controllerToSend.challengerMove = round.playerMoves[1]
            
            //obtendo imagem do challenger
            let challengerCardId : Int =  Int(round.playerMoves[1].cardId)!
            controllerToSend.challengerMove.image = getImageFromUrl(imageUrl: self.cards[challengerCardId - 1].heroImage)
        }else{
            controllerToSend.playerMove = round.playerMoves[1]
            controllerToSend.challengerMove = round.playerMoves[0]
            
            //obtendo imagem do challenger
            let challengerCardId : Int =  Int(round.playerMoves[0].cardId)!
            controllerToSend.challengerMove.image = getImageFromUrl(imageUrl: self.cards[challengerCardId - 1].heroImage)
        }
    
    //    controllerToSend.playerMove = playerMove
      //  controllerToSend.challengerMove = challengerMove
        
        //enviando o usuario para a pagina da batalha
        navigationController?.pushViewController(controllerToSend, animated: true)
    }
    
}
