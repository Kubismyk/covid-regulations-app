//
//  ProfileViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 25.01.22.
//

import UIKit
import Photos
import Firebase
import FirebaseStorage
import FirebaseAuth
import Kingfisher

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
    
    var myImage:UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        profileDesign()
        self.mainProfilePicImage.kf.setImage(with: URL(string: usefulValuesFetchedFromFirebase.profileImageUrl))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.usernameText.text = usefulValuesFetchedFromFirebase.username
        self.usernameLabel.text = usefulValuesFetchedFromFirebase.username
        self.emailText.text = usefulValuesFetchedFromFirebase.nationality
        self.isUserVaccinatedText.text = usefulValuesFetchedFromFirebase.vaccine
        self.mainProfilePicImage.layer.masksToBounds = true
        self.mainProfilePicImage.layer.cornerRadius = 30
        self.mainProfilePicImage.contentMode = .scaleToFill
        //self.mainProfilePicImage.kf.setImage(with: URL(string: usefulValuesFetchedFromFirebase.profileImageUrl))
    }
    
    
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let alert = UIAlertController(title: "Profile Picture", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose Picture From Library", style: .default , handler:{ (UIAlertAction)in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            self.present(vc,animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Remove Profile Picutre", style: .default , handler:{ (UIAlertAction)in
            self.mainProfilePicImage.kf.setImage(with: URL(string: RegisterViewController.staticProfileImageUrlString))
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser!.uid
            db.collection("users")
                .whereField("uid", isEqualTo: userID)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Couldnt update : \(err)")
                    } else {
                        let document = querySnapshot!.documents.first
                        document!.reference.updateData([
                            "profileImageUrl": RegisterViewController.staticProfileImageUrlString
                        ])
                    }
                }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        
        //uncomment for iPad Support
        alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
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
    

}



extension ProfileViewController:UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {


        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.mainProfilePicImage.layer.masksToBounds = true
            self.mainProfilePicImage.layer.cornerRadius = 30
            self.mainProfilePicImage.image = image
            print("image:\(image)")
        }
        
        guard let imageData = self.mainProfilePicImage.image?.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        let userID = Auth.auth().currentUser!.uid
        let storageRef = Storage.storage().reference(forURL: "gs://covidregulationsapp.appspot.com/")
        let storageProfileRef = storageRef.child("profile").child(userID)

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageProfileRef.putData(imageData,metadata: metadata) { (storageMetadata, error) in
            if error != nil {
            print("error")
            }
            storageProfileRef.downloadURL(completion: {(url,error) in
                if let metaImageUrl = url?.absoluteString {
                }
                let db = Firestore.firestore()
                db.collection("users")
                    .whereField("uid", isEqualTo: userID)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Couldnt update : \(err)")
                        } else {
                            let document = querySnapshot!.documents.first
                            document!.reference.updateData([
                                "profileImageUrl": url?.absoluteString
                            ])
                        }
                    }
            })
        }
        
        picker.dismiss(animated: true, completion: nil)

        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
}
