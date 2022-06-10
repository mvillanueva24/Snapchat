//
//  RegistrarseViewController.swift
//  Snapchat
//
//  Created by Mario Villanueva Linares on 6/10/22.
//  Copyright © 2022 mvillanueva24. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrarseViewController: UIViewController {

    @IBOutlet weak var usuarioText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegistrarseTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.usuarioText.text!, password: self.passwordText.text!, completion: {(user, error) in
            print("Intentando crear un usuario")
            if error != nil{
                print("Se presento el siguiente error al crear el usuario: \(error)")
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "No se creo correctamente", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: {(UIAlertAction) in
                })
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            } else{
                print("El usuario fue creado exitosamente")
            Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario \(self.usuarioText.text!) se creo correctamente", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: {(UIAlertAction) in
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                })
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
