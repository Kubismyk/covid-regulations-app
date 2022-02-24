//
//  GuestHomePageViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 16.02.22.
//

import UIKit

class GuestHomePageViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    
    @IBOutlet weak var chooseDestinationButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guestSideDesgin()
    }
    

    func guestSideDesgin(){
        welcomeLabel.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-semibold")
        textLabel.FontStyle(fontSize: 40, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand")
        chooseDestinationButton.buttonShadow(shadowColor: .black, shadowX: 0, shadowY: 4, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 9)
        chooseDestinationButton.titleLabel?.font = UIFont(name: "QuickSand-semibold", size: 20)
        backToLoginButton.buttonShadow(shadowColor: .black, shadowX: 0, shadowY: 4, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 9)
        backToLoginButton.titleLabel?.font = UIFont(name: "QuickSand-bold", size: 14)
        
    }
    
    @IBAction func chooseDestinationButtonTapped(_ sender: UIButton) {
        Vibration.soft.vibrate()
    }
    
    @IBAction func backToLoginTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
