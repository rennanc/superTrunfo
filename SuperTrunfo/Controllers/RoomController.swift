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
    @IBOutlet weak var labelSkill1: UILabel!
    @IBOutlet weak var labelSkill2: UILabel!
    @IBOutlet weak var labelSkill3: UILabel!
    @IBOutlet weak var labelSkill4: UILabel!
    @IBOutlet weak var labelSkill5: UILabel!
    
    
    //itens de tela do jogador
    @IBOutlet weak var labelNumberOfCards: UILabel!
    @IBOutlet weak var labelNumCardsInDeck: UILabel!
    
    @IBOutlet weak var labelNumWinner: UILabel!
    @IBOutlet weak var labelNumDefeat: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
