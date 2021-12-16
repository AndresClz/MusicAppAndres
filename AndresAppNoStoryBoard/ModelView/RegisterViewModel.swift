//
//  RegisterViewModel.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 10/12/2021.
//

import UIKit

class RegisterViewModel: UIViewController {
    let model: Registered = Registered()
    var validUser = false
    var errorAnimation : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    func botonRegisterTouch(user:String?, pass:String?) {
        
        guard let username = user, !username.isEmpty else{
            print("Email Vacio")
            errorAnimation = 1
            //Email Vacio
            return
        }
        
        guard username.lowercased().isValidEmail() else{
            //Email Invalido
            errorAnimation = 1
            return
        }
        guard let password = pass, !password.isEmpty else{
            //Password Vacia
            errorAnimation = 2
            return
        }
        guard password.isValidPassword() else{
            //Password no valida
            errorAnimation = 2
            return
        }
        if model.user1.user == user && model.user1.pass == password{
            validUser = true
        } else {
            errorAnimation = nil
            print("Usuario no encontrado")
        }
    }
}
