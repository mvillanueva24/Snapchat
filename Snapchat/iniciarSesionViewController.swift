//
//  ViewController.swift
//  Snapchat
//
//  Created by Mario Villanueva Linares on 5/27/22.
//  Copyright © 2022 mvillanueva24. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Googleconf()
    }
    
    private func Googleconf(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            print("Intentando Iniciar Sesion")
            if let error = error{
                print("Se presento el siguiente error: \(error)")
            }
            else{
                print("Inicio de sesion exitoso")
            }
        }
    }
    
    @IBAction func GoogleSignin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }

}

extension iniciarSesionViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print("Error because \(error.localizedDescription)")
            return
        }

        guard let auth = user.authentication else {return}
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)

        Auth.auth().signIn(with: credentials){ (authResult, error) in
            if let error = error{
                print("Error because \(error.localizedDescription)")
                return
            }
        }
    }

}
