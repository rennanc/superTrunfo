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

class LoginController : UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
   // let loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GIDSignIn.sharedInstance().uiDelegate = self
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
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        
        
        // ...
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    @IBAction func signIn(_ sender: GIDSignInButton) {
        
        GIDSignIn.sharedInstance().signIn()
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if segue.identifier == "segueLobby"{
            if let navigationViewController = segue.destination as? UINavigationController, let myViewController = navigationVC.topViewController as? MyViewControllerClass {
                myViewController.yourProperty = myProperty
            }
        }*/
    }*/
    
    
    //envia para a pagina de lobby com as salas
    func sendToLobby(){
        performSegue(withIdentifier: "segueLobby", sender: self)
        //let destinationNavigationController = segue.destination as! UINavigationController
        //let targetController = destinationNavigationController.topViewController
    }
    
    
}
