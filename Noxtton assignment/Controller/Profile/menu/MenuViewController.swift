//
//  MenuViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 28.01.22.
//

import UIKit
import FirebaseAuth
class MenuViewController: UIViewController {

    
    override func viewDidLoad() {
        
    }
    

    @IBAction func logOutTapped(_ sender: Any) {
        try! Auth.auth().signOut()

        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController =
        storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        loginViewController?.modalTransitionStyle = .partialCurl
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
}
