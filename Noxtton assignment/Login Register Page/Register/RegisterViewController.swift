//
//  RegisterViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 15.01.22.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var alreadyRegistered: UILabel!
    @IBOutlet weak var RegisterLabel: UILabel!
        
    @IBOutlet weak var usernameLabelRegister: UITextField!
    @IBOutlet weak var passwordLabelRegister: UITextField!
    @IBOutlet weak var repeatPasswordLabelRegister: UITextField!
    @IBOutlet weak var vactinationInfo: UIButton!
    @IBOutlet weak var currentLocationInfo: UIButton!
    @IBOutlet weak var confirmRegisterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerDesign()
        
    }
    
    
    
    func registerDesign(){
        alreadyRegistered.FontStyle(fontSize: 15, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-light")
        
        confirmRegisterButton.buttonShadow(shadowColor: .gray, shadowX: 2, shadowY: 4, shadowOpacity: 0.3, shadowRadius: 4, cornerRadius: 15)
        confirmRegisterButton.buttonFontAndSize(fontFamily: "QuickSand-semibold", fontSize: 18)
        
        vactinationInfo.buttonShadow(shadowColor: .black, shadowX: 4, shadowY: 4, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 15)
        
        
        vactinationInfo.layer.borderWidth = 0.5
        vactinationInfo.layer.borderColor = UIColor(named: "myGray")?.cgColor
        
        vactinationInfo.buttonFontAndSize(fontFamily: "QuickSand", fontSize: 18)
        vactinationInfo.buttonShadow(shadowColor: .gray, shadowX: 2, shadowY: 4, shadowOpacity: 0.3, shadowRadius: 4, cornerRadius: 15)
        vactinationInfo.buttonShadow(shadowColor: .gray, shadowX: 2, shadowY: 4, shadowOpacity: 0.3, shadowRadius: 4, cornerRadius: 15)
        
        
        RegisterLabel.FontStyle(fontSize: 64, shadowRadius: 4, shadowOpacity: 0.25, shadowX: 0, shadowY: 4, fontFamily: "QuickSand-bold")
        
        // username
        
        usernameLabelRegister.textFieldStyle(CornerRadius: 15, BorderWidth: 0.5, BorderColor: .gray, Placeholder: "username", FontFamily: "QuickSand-light", TextColor: .gray)
        usernameLabelRegister.addShadow(ShadowRadius: 4, ShadowColor: .gray, ShadowOpacity: 0.25, ShadowX: 0, ShadowY: 2)
        usernameLabelRegister.addInnerShadow(innerShadowColor: .white, innerShadowX: -5, innerShadowY: -5, innerShadowOpacity: 1, innerShadowRadius: 10)
        usernameLabelRegister.addInnerShadow(innerShadowColor: .blue, innerShadowX: 5, innerShadowY: 5, innerShadowOpacity: 0.5, innerShadowRadius: 10)
        
        if let usernameLeftImage = UIImage(systemName: "person.crop.circle")?.withTintColor(UIColor(named: "MainBlue")!, renderingMode: .alwaysOriginal){
            usernameLabelRegister.withImage(direction: .Left, image: usernameLeftImage, colorSeparator: .lightGray, colorBorder: .black)
        }
        
        //password
        
        passwordLabelRegister.textFieldStyle(CornerRadius: 15, BorderWidth: 0.5, BorderColor: .gray, Placeholder: "password", FontFamily: "QuickSand-light", TextColor: .gray)
        passwordLabelRegister.addShadow(ShadowRadius: 4, ShadowColor: .gray, ShadowOpacity: 0.25, ShadowX: 0, ShadowY: 2)
        passwordLabelRegister.addInnerShadow(innerShadowColor: .white, innerShadowX: -5, innerShadowY: -5, innerShadowOpacity: 1, innerShadowRadius: 10)
        passwordLabelRegister.addInnerShadow(innerShadowColor: .blue, innerShadowX: 5, innerShadowY: 5, innerShadowOpacity: 0.5, innerShadowRadius: 10)
        
        if let passwordLeftImage = UIImage(systemName: "lock.fill")?.withTintColor(UIColor(named: "MainBlue")!,renderingMode: .alwaysOriginal) {
            passwordLabelRegister.withImage(direction: .Left, image: passwordLeftImage, colorSeparator: .lightGray, colorBorder: .black)
        }
        
        //repeat password
        
        repeatPasswordLabelRegister.textFieldStyle(CornerRadius: 15, BorderWidth: 0.5, BorderColor: .gray, Placeholder: "repeat password", FontFamily: "QuickSand-light", TextColor: .gray)
        repeatPasswordLabelRegister.addShadow(ShadowRadius: 4, ShadowColor: .gray, ShadowOpacity: 0.25, ShadowX: 0, ShadowY: 2)
        repeatPasswordLabelRegister.addInnerShadow(innerShadowColor: .white, innerShadowX: -5, innerShadowY: -5, innerShadowOpacity: 1, innerShadowRadius: 10)
        repeatPasswordLabelRegister.addInnerShadow(innerShadowColor: .blue, innerShadowX: 5, innerShadowY: 5, innerShadowOpacity: 0.5, innerShadowRadius: 10)
        
        if let passwordLeftImage = UIImage(systemName: "lock.fill")?.withTintColor(UIColor(named: "MainBlue")!,renderingMode: .alwaysOriginal) {
            repeatPasswordLabelRegister.withImage(direction: .Left, image: passwordLeftImage, colorSeparator: .lightGray, colorBorder: .black)
        }
        
        
    }
    @IBAction func logInButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
