//
//  Game.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 14/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit

//painel de status do jogador
struct Panel{
    var numberOfCards: Int!
    var numberCardInDeck: Int!
    var numberWinners: Int!
    var numberDefeats: Int!
    
    init(){
        numberOfCards = 0
        numberCardInDeck = 0
        numberWinners = 0
        numberDefeats = 0
    }
}
