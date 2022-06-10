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
import FirebaseDatabase

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
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario \(self.emailTextField.text!) no esta registrado", preferredStyle: .alert)
                let btnCrear = UIAlertAction(title: "Crear", style: .default, handler: {(UIAlertAction) in
                    self.performSegue(withIdentifier: "registerSegue", sender: nil)
                })
                let btnCancel = UIAlertAction(title: "Cancel", style: .default, handler: {(UIAlertAction) in
                })
                alerta.addAction(btnCrear)
                alerta.addAction(btnCancel)
                self.present(alerta, animated: true, completion: nil)

            }
            else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    @IBAction func GoogleSignin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }

    @IBAction func crearUsuarioTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
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
