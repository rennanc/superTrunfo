//
//  LoginController.swift
//  SuperTrunfo
//
//  Created by Rennan Chagas on 17/09/17.
//  Copyright © 2017 Rennan Chagas. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginController : UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signInButtonFB: FBSDKLoginButton!
    
   // let loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adicionando fundo na view
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image =  UIImage(named: "loginMarvel")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        

        
        //GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        //loginButton.delegate = self
    }
    
    //criacao de nova conta
    @IBAction func createNewAccount(_ sender: Any){
        if  let login = txtLogin.text, let password = txtPassword.text {
            Auth.auth().createUser(withEmail: login, password: password) { (user, error) in
                
                if let error = error {
                    self.showErrorMessage(title: "Erro", message: error.localizedDescription)
                    return
                }
                
                self.showSuccessMessage(title: "Sucesso",message: "Conta \(user!.email!) criada com sucesso!")
            }
        }
    }
    
    //Login com email e senha
    @IBAction func signInDefault(_ sender: Any){
        if  let login = txtLogin.text, let password = txtPassword.text {
            Auth.auth().signIn(withEmail: login, password: password) { (user, error) in
                
                if let error = error {
                    self.showErrorMessage(title: "Erro", message: error.localizedDescription)
                    return
                }
                
                //self.showSuccessMessage(title: "Logado",message: "Logado com sucesso")
                self.sendToLobby()
            }
        }
    }
    
    //envia para a pagina de lobby com as salas
    func sendToLobby(){
        performSegue(withIdentifier: "segueLobby", sender: self)
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        if let user = Auth.auth().currentUser {
            user.link(with: credential) { (user, error) in
                if let error = error {
                    self.showErrorMessage(message: error.localizedDescription)
                    return
                }
                self.sendToLobby()
            }
        } else {
            //logando com credencial
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    self.showErrorMessage(message: error.localizedDescription)
                    return
                }
                self.sendToLobby()
            }
        }
    }
    
    
    @IBAction func signInFacebook(_ sender: Any){
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if let error = error {
                self.showErrorMessage(message: error.localizedDescription)
            } else if result!.isCancelled {
                print("FBLogin cancelled")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseLogin(credential)
            }
        })
    }
    
    
}
