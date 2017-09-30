//
//  MessageUtil.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 25/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSuccessMessage(title : String, message: String){
        //Mostrar
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil ))
        
        alert.view.backgroundColor = UIColor.green
        
        //exibir alerta tela na tela atual
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorMessage(title : String = "Erro", message: String){
        //Mostrar
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil ))
        
        alert.view.backgroundColor = UIColor.red
        
        //exibir alerta tela na tela atual
        self.present(alert, animated: true, completion: nil)
    }
    
    func showInfoMessage(title : String = "Info", message: String){
        //Mostrar
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil ))
        
        alert.view.backgroundColor = UIColor.blue
        
        //exibir alerta tela na tela atual
        self.present(alert, animated: true, completion: nil)
    }
}
