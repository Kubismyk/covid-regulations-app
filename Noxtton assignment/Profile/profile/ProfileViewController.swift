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
    override func viewDidLoad() {
        super.viewDidLoad()

        profileDesign()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.usernameText.text = usefulValuesFetchedFromFirebase.username
        self.usernameLabel.text = usefulValuesFetchedFromFirebase.username
        self.emailText.text = usefulValuesFetchedFromFirebase.nationality
        self.isUserVaccinatedText.text = usefulValuesFetchedFromFirebase.vaccine
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
        myInfoLabel.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-bold")
    }
    
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let alert = UIAlertController(title: "Profile Picture", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "choose picture from library", style: .default , handler:{ (UIAlertAction)in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            self.present(vc,animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "remove profile picutre", style: .default , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    

}


extension ProfileViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedPicture")] as? UIImage {
            self.mainProfilePicImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
