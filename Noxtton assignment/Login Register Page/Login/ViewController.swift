//
//  ViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 12.01.22.
//

import UIKit

class ViewController: UIViewController {
    // Main label below
    @IBOutlet weak var LoginLabel: UILabel!
    
    // TextFields below
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Buttons below
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var beGuestButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginDesign()
    }

    
    @IBAction func goToRegisterButton(_ sender: Any) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle:nil)
//
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterStoryboard") as! RegisterViewcontroller
//        self.present(nextViewController, animated:true, completion:nil)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewcontroller
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
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
        forgetPasswordButton.buttonStyle(buttonPositionX: 0, buttonPositionY: 0, buttonWidth: 98, buttonHeight: 24, buttonTilte: "forget password?", backgroundColor: .white, titleColor: .gray)
        forgetPasswordButton.buttonFontAndSize(fontFamily: "QuickSand-light", fontSize: 13)
        
        
    }
    
}


