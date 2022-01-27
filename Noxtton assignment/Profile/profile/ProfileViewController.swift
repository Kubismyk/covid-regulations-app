//
//  ProfileViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 25.01.22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var mainBackdrop: UIView!
    @IBOutlet weak var mainProfilePicImage: UIImageView!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var Labels: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var isVaccinated: UILabel!
    @IBOutlet weak var myInfoLabel: UILabel!
    
    // useful labels below beside design
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var isUserVaccinatedText: UILabel!
    @IBOutlet weak var whichVaccineText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        profileDesign()
    }
    

    func profileDesign(){
        mainBackdrop.dropShadow(shadowColor: .white, shadowX: 0, shadowY: 0, shadowOpacity: 0.5, shadowRadius: 20)
        mainBackdrop.layer.cornerRadius = 30
        
        mainProfilePicImage.layer.cornerRadius = 40
        mainProfilePicImage.dropShadow(shadowColor: .white, shadowX: 0, shadowY: 0, shadowOpacity: 0.5, shadowRadius: 20)
        usernameLabel.FontStyle(fontSize: 33, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 0, fontFamily: "QuickSand-bold")
        
        Labels.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
        emailLabel.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
        
        emailText.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
        usernameText.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
        isUserVaccinatedText.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
        whichVaccineText.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
        myInfoLabel.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-bold")
    }
    

}
