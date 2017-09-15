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
    
    var listOfSkills = [UILabel]()
    
    
    //itens de tela do jogador
    @IBOutlet weak var labelNumberOfCards: UILabel!
    @IBOutlet weak var labelNumCardsInDeck: UILabel!
    
    @IBOutlet weak var labelNumWinner: UILabel!
    @IBOutlet weak var labelNumDefeat: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //configura acoes de gesto para as labels de skill
    func setupSkillsTapGesture(){
        //definindo quais labels receberao a funca
        listOfSkills = [UILabel](arrayLiteral: labelSkill1,
                                 labelSkill2,
                                 labelSkill3,
                                 labelSkill4,
                                 labelSkill5)
        
        for labelSkill in listOfSkills{
            let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(self.selectSkill))
            tapGesture.isEnabled = true
            labelSkill.addGestureRecognizer(tapGesture)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectSkill(sender: UITapGestureRecognizer){
        var selectedLabel : UIView = sender.view!
        print("tap funcionando. tag: " + String(selectedLabel.tag))
    }
    
    
    
}
