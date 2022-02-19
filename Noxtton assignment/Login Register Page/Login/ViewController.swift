//
//  ViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 12.01.22.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    // Main label below
    @IBOutlet weak var LoginLabel: UILabel!
    
    // TextFields below
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // Buttons below
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var beGuestButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginDesign()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func loginButton(_ sender: UIButton) {
        sender.keyboardAnimationView()
        let email = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //login user
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                self.errorLabel.text = "Email or Password is incorrect."
                self.errorLabel.alpha = 1
            } else {
                self.transitionToHome()
            }
        }
    }
    func transitionToHome(){
        let storyBoard = UIStoryboard(name: "HomePage", bundle: nil)
        let tabViewController =
        storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
        view.window?.rootViewController = tabViewController
        view.window?.makeKeyAndVisible()
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    @IBAction func goToRegisterButton(_ sender: Any) {
        
    }
    
    
    func loginDesign(){
        LoginLabel.FontStyle(fontSize: 64, shadowRadius: 4, shadowOpacity: 0.25, shadowX: 0, shadowY: 4, fontFamily: "QuickSand-bold")
        
        if let usernameLeftImage = UIImage(systemName: "person.crop.circle")?.withTintColor(UIColor(named: "MainBlue")!, renderingMode: .alwaysOriginal){
        usernameTextField.withImage(direction: .Left, image: usernameLeftImage, colorSeparator: .lightGray, colorBorder: .black)
        }
        usernameTextField.textFieldStyle(CornerRadius: 15, BorderWidth: 0.5, BorderColor: .gray, Placeholder: "username", FontFamily: "QuickSand-light", TextColor: .gray)
        usernameTextField.addShadow(ShadowRadius: 4, ShadowColor: .gray, ShadowOpacity: 0.25, ShadowX: 0, ShadowY: 2)
        
        
        if let passwordLeftImage = UIImage(systemName: "lock.fill")?.withTintColor(UIColor(named: "MainBlue")!,renderingMode: .alwaysOriginal) {
            passwordTextField.withImage(direction: .Left, image: passwordLeftImage, colorSeparator: .lightGray, colorBorder: .black)
        }
        passwordTextField.textFieldStyle(CornerRadius: 15, BorderWidth: 0.5, BorderColor: .gray, Placeholder: "password", FontFamily: "QuickSand-light", TextColor: .gray)
        passwordTextField.addShadow(ShadowRadius: 4, ShadowColor: .gray, ShadowOpacity: 0.25, ShadowX: 0, ShadowY: 2)
        // Textfield inner shadows
        passwordTextField.addInnerShadow(innerShadowColor: .white, innerShadowX: -5, innerShadowY: -5, innerShadowOpacity: 1, innerShadowRadius: 10)
        usernameTextField.addInnerShadow(innerShadowColor: .white, innerShadowX: -5, innerShadowY: -5, innerShadowOpacity: 1, innerShadowRadius: 10)
        usernameTextField.addInnerShadow(innerShadowColor: .blue, innerShadowX: 5, innerShadowY: 5, innerShadowOpacity: 0.5, innerShadowRadius: 10)
        passwordTextField.addInnerShadow(innerShadowColor: .blue, innerShadowX: 5, innerShadowY: 5, innerShadowOpacity: 0.5, innerShadowRadius: 10)
        
        signInButton.buttonShadow(shadowColor: .gray, shadowX: 2, shadowY: 4, shadowOpacity: 0.3, shadowRadius: 4, cornerRadius: 15)
        beGuestButton.buttonShadow(shadowColor: .gray, shadowX: 2, shadowY: 4, shadowOpacity: 0.3, shadowRadius: 4, cornerRadius: 15)
        signInButton.buttonFontAndSize(fontFamily: "QuickSand-semibold", fontSize: 18)
        beGuestButton.buttonFontAndSize(fontFamily: "QuickSand-semibold", fontSize: 18)
        errorLabel.dropShadow(shadowColor: .red, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
        errorLabel.font = UIFont(name: "QuickSand-light", size: 20)
    }

    @IBAction func usernameTextFieldTapped(_ sender: UITextField) {
        sender.keyboardAnimation()
    }
    
}


