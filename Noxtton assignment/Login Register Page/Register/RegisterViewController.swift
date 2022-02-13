//
//  RegisterViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 15.01.22.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController,vaccineDataSentToRegisterViewControllerProtocol {
    func sendDataToFirstViewController(myData: String) {
        self.chosenVaccine = myData
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDataSegue" {
            let secondVC: vactinationCollectionViewController = segue.destination as! vactinationCollectionViewController
            secondVC.delegate = self
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var chosenVaccine:String = ""
    
    @IBOutlet weak var alreadyRegistered: UILabel!
    @IBOutlet weak var RegisterLabel: UILabel!
        
    @IBOutlet weak var usernameLabelRegister: UITextField!
    @IBOutlet weak var passwordLabelRegister: UITextField!
    @IBOutlet weak var repeatPasswordLabelRegister: UITextField!
    @IBOutlet weak var vactinationInfo: UIButton!
    @IBOutlet weak var confirmRegisterButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
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
        //email
        
        emailTextField.textFieldStyle(CornerRadius: 15, BorderWidth: 0.5, BorderColor: .gray, Placeholder: "email", FontFamily: "QuickSand-light", TextColor: .gray)
        emailTextField.addInnerShadow(innerShadowColor: .white, innerShadowX: -5, innerShadowY: -5, innerShadowOpacity: 1, innerShadowRadius: 10)
        emailTextField.addInnerShadow(innerShadowColor: .blue, innerShadowX: 5, innerShadowY: 5, innerShadowOpacity: 0.5, innerShadowRadius: 10)
        emailTextField.addShadow(ShadowRadius: 4, ShadowColor: .gray, ShadowOpacity: 0.25, ShadowX: 0, ShadowY: 2)
        
        if let emailLeftImage = UIImage(systemName: "envelope.fill")?.withTintColor(UIColor(named: "MainBlue")!,renderingMode: .alwaysOriginal) {
            emailTextField.withImage(direction: .Left, image: emailLeftImage, colorSeparator: .lightGray, colorBorder: .black)
        }
        
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
        
        //error label
        
        errorLabel.dropShadow(shadowColor: .red, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
        errorLabel.font = UIFont(name: "QuickSand-light", size: 20)
        
    }
    
    func validateData() -> String? {
        func showErrorTwo(_ message: String) {
            self.errorLabel.text = message
            self.errorLabel.alpha = 1
        }
        if usernameLabelRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordLabelRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || repeatPasswordLabelRegister.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
              
                self.errorLabel.text = "Please fill in all line."
                self.errorLabel.alpha = 1
            
                return "Please fill in all line"
            
        }
//        if passwordLabelRegister.text!.trimmingCharacters(in: .whitespacesAndNewlines) != repeatPasswordLabelRegister.text!.trimmingCharacters(in: .whitespacesAndNewlines) {
//            showErrorTwo("password doesn't match repeated password.")
//
//            return "hello"
//        }
//        if emailTextField.text!.isValidEmail() == false {
//            showErrorTwo("email is not valid.")
//
//            return "hello2"
//        }
        let cleanedPassword = passwordLabelRegister.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
        self.errorLabel.text = "Please make sure password is at least 8 characters, contains a special character and a number."
        self.errorLabel.alpha = 1
        return "Please make sure password is at least 8 characters, contains a special character and a number."
        
    }
        return nil
}
    
    @IBAction func logInButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func transitionToHome(){
        let storyBoard = UIStoryboard(name: "HomePage", bundle: nil)
        let tabViewController =
        storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
        view.window?.rootViewController = tabViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let error = validateData()
        if error != nil{
            print("\(error)")
        }else {
            let username = usernameLabelRegister.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordLabelRegister.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let repeatPassword = repeatPasswordLabelRegister.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            

            
            
            // create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // check for errors
                
                if let err = err {
                    // error occuried
                    showError("error while creating user")
                }else {
                    // user was created succesfully,store name and vaccine
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["username":self.usernameLabelRegister.text ,"vaccine":self.chosenVaccine, "uid":result!.user.uid]) { error in
                        if error != nil {
                            // show error
                            showError("user data blablabla")
                        }
                    }
                    self.transitionToHome()
                }
            }
            func showError(_ message: String) {
                self.errorLabel.text = error ?? "no error"
                self.errorLabel.alpha = 1
            }
    }
        
    
        
}

}
