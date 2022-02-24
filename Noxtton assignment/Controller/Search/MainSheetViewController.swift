//
//  MainSheetViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 06.02.22.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher
import FirebaseFirestore

protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: SavedCountries)
}


class MainSheetViewController: UIViewController {
        

    //@IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var myNationalityLabel: UILabel!
    @IBOutlet weak var myVaccineLabel: UILabel!
    @IBOutlet var apiLabels: [UILabel]!
    @IBOutlet var labelsCollection: [UILabel]!
    @IBOutlet var biggerLabelsCollection: [UILabel]!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var airport: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    var info:String = ""
    var a:String = ""
    var b:String = ""
    var c:String = ""
    //var d:String = ""
    var d:String = ""
    var generalInfo = String()
    
    
    // travel regulations labels below
    
    @IBOutlet weak var touristsAllowedToVisitLabel: UILabel!
    @IBOutlet weak var businessVisitsAllowed: UILabel!
    @IBOutlet weak var covidPassportRequiredAllowed: UILabel!
    @IBOutlet weak var pCRTestsForNonResidents: UILabel!
    @IBOutlet weak var pCRTestForResidents: UILabel!
    
    
    //restrictions by vaccination labels below
    
    
    @IBOutlet weak var VaccinationDozesRequired: UILabel!
    @IBOutlet weak var minimumDaysAfterVaccination: UILabel!
    @IBOutlet weak var maxDaysAfterVaccination: UILabel!
    
    
    //restrictions by nationality labels below
    
    
    @IBOutlet weak var allowsTouristsNationalitty: UILabel!
    @IBOutlet weak var allowsBusinessVisitsNationality: UILabel!
    @IBOutlet weak var pCRRequiredNationality: UILabel!
    @IBOutlet weak var fastTestRequiredNationality: UILabel!
    @IBOutlet weak var biometricPassportRequiredNationality: UILabel!
    @IBOutlet weak var locatorFormRequiredNationality: UILabel!
    @IBOutlet weak var covidPassportRequiredNationality: UILabel!
    
    @IBOutlet weak var myNationalityText: UILabel!
    
    @IBOutlet weak var myVaccineText: UILabel!
    @IBOutlet weak var generalInfoLabel: UILabel!
    
    @IBOutlet weak var popUpButton: UIButton!
    
    
    @IBOutlet var transferApiLabels: [UILabel]!
    @IBOutlet var transferLabelsCollection: [UILabel]!
    
    // transfers
    @IBOutlet weak var transferTouristsAllowed: UILabel!
    @IBOutlet weak var transferBusinessVisits: UILabel!
    @IBOutlet weak var pCRTransfers: UILabel!
    @IBOutlet weak var pCRNonResidentsTransfer: UILabel!
    
    @IBOutlet weak var covidPassportTransfer: UILabel!
    
    @IBOutlet weak var transferCountryInfo: UILabel!
    
    @IBOutlet var allTransferLabels: [UILabel]!
    
    
    
    static var delegate: savedDataSendingDelegateProtocolo? = nil
    
    
    

    var testInfo:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTransferApisDissapear()
        let optionsClosure = { (action: UIAction) in
            let chosenAirport = action.title
            switch chosenAirport {
            case "Tbilisi airport":
                self.getAPI(data: "TBS")
            case "Riga airport":
                self.getAPI(data: "RIX")
            case "Tallinn airport":
                self.getAPI(data: "TLL")
            case "Berlin airport":
                self.getAPI(data: "BER")
            case "Geneva airport":
                self.getAPI(data: "GVA")
            default:
                print("")
            }
        }
        popUpButton.changesSelectionAsPrimaryAction = true
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.menu = UIMenu(children: [
          UIAction(title: "Tbilisi airport", state: .on, handler: optionsClosure),
          UIAction(title: "Riga airport", handler: optionsClosure),
          UIAction(title: "Tallinn airport", handler: optionsClosure),
          UIAction(title: "Berlin airport", handler: optionsClosure),
          UIAction(title: "Geneva airport", handler: optionsClosure),
        ])
        
        
        setupDesign()
        self.countryTitle.text = a
        self.airport.text = b
        self.countryImage.image = self.cityImage.image
        setUpEveryThing()
        apiLabels.forEach {
            $0.FontStyle(fontSize: 16, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-semibold")
        }
        transferApiLabels.forEach {
            $0.FontStyle(fontSize: 16, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-semibold")
        }
        myNationalityLabel.text = UsefulValuesFetchedFromFirebase.nationality
        myNationalityLabel.FontStyle(fontSize: 17, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        myVaccineLabel.text = UsefulValuesFetchedFromFirebase.vaccine
        myVaccineLabel.FontStyle(fontSize: 17, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        myNationalityText.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
        myVaccineText.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
    }
    
    func makeTransferApisDissapear(){
        self.allTransferLabels.forEach { labels in
            labels.alpha = 0
        }
    }
    func makeTransferApisAppear(){
        self.allTransferLabels.forEach { labels in
            labels.alpha = 1
        }
    }
    
    
    
    func setUpEveryThing(){
        self.generalInfoLabel.text! = generalInfo
        

        
        
        APIServicies.getRestrictionsInfo(from: UsefulValuesFetchedFromFirebase.nationality ,
                                         countryCode: self.testInfo ,
                                         to: self.info ,
                                         with: UsefulValuesFetchedFromFirebase.vaccine , completion: { result in
                    switch result {
                    case .success(let restrictions):
                                                
                        var generalRestrictions:APIServicies.GeneralRestricitons
                        generalRestrictions = restrictions.generalRestricitons!
                        
                        var vaccinationRestrictions:APIServicies.RestrictionsByVaccination
                        vaccinationRestrictions = restrictions.byVaccination!
                        
                        var nationalityRestrictions:APIServicies.RestrictionsByNationalityData
                        nationalityRestrictions = restrictions.byNationality!
                        
                        DispatchQueue.main.async{
                            
                            //travel regulations
                            
                            self.generalInfoLabel.text! = generalRestrictions.generalInformation
                            self.touristsAllowedToVisitLabel.text = String("\(generalRestrictions.allowsTourists)")
                            self.touristsAllowedToVisitLabel.isTrueOrFalse()
                            self.businessVisitsAllowed.text = String("\(generalRestrictions.allowsBusinessVisit)")
                            self.covidPassportRequiredAllowed.text = String("\(generalRestrictions.covidPassportRequired)")
                            self.pCRTestsForNonResidents.text = String("\(generalRestrictions.pcrRequiredForNoneResidents)")
                            self.pCRTestForResidents.text = String("\(generalRestrictions.pcrRequiredForResidents)")
                            
                            
                            // vax.regulations
                            
                            self.VaccinationDozesRequired.text = String("\(vaccinationRestrictions.dozesRequired)")
                            self.minimumDaysAfterVaccination.text = String("\(vaccinationRestrictions.minDaysAfterVaccination)")
                            self.maxDaysAfterVaccination.text = String("\(vaccinationRestrictions.maxDaysAfterVaccination)")
                            
                            // nationality regulations
                            
                            self.allowsTouristsNationalitty.text = String("\(nationalityRestrictions.allowsTourists!)")
                            self.allowsBusinessVisitsNationality.text = String("\(nationalityRestrictions.allowsBusinessVisit!)")
                            self.pCRRequiredNationality.text = String("\(nationalityRestrictions.pcrRequired!)")
                            self.fastTestRequiredNationality.text = String("\(nationalityRestrictions.fastTestRequired!)")
                            self.biometricPassportRequiredNationality.text = String("\(nationalityRestrictions.biometricPassportRequired!)")
                            self.locatorFormRequiredNationality.text = String("\(nationalityRestrictions.locatorFormRequired!)")
                            self.covidPassportRequiredNationality.text = String("\(nationalityRestrictions.covidPassportRequired!)")
                            self.apiLabels.forEach {
                                $0.isTrueOrFalse()
                            }
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                })
    }
    
    var cityImage = UIImageView()
    
    var delegate: MyDataSendingDelegateProtocol? = nil

    @IBAction func mainButtonClick(_ sender: UIButton) {
        


        
        let userID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()

        
        
        guard let imageData = self.countryImage.image?.jpegData(compressionQuality: 0.4) else {
            return
        }
        let storageRef = Storage.storage().reference(forURL: "gs://covidregulationsapp.appspot.com/")
        let uuid = UUID().uuidString
        let storageProfileRef = storageRef.child("savedImage").child(userID).child(uuid)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageProfileRef.putData(imageData,metadata: metadata)
        { (storageMetadata, error) in
            if error != nil {
            print("error")
            }
            storageProfileRef.downloadURL(completion: {(url,error) in
                if self.delegate != nil {
                    let dataToBeSent:SavedCountries = SavedCountries(code: self.info, country: self.a, city: self.b, image: url!.absoluteString)
                    self.delegate?.sendDataToFirstViewController(myData: dataToBeSent)
                    //dismiss(animated: true, completion: nil)
                }
                let db = Firestore.firestore()
                db.collection("users/\(userID)/saved")
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Couldnt update : \(err)")
                        } else {
                            db.collection("users/\(userID)/saved").addDocument(data: [
                                "country":self.countryTitle.text!,
                                "code":self.info,
                                "city":self.airport.text!,
                                "countryImage": url?.absoluteString
                                
                            ])
                        }
                    }
            })
            
        }

        

        dismiss(animated: true, completion: nil)
    }
    func configWith(data:MixedData) {
        self.cityImage.image = data.image
        self.a = data.country
        self.b = data.city
        self.info = data.code
    }
    
    func secondConfigure(data:SavedCountries){
        let url = URL(string: data.image)
        self.cityImage.kf.setImage(with:url)
        self.a = data.country
        self.b = data.city
        self.info = data.code
    }
    
    
    @IBAction func menuButton(_ sender: Any) {
    }
    
    
    
    func setupDesign(){
        labelsCollection.forEach {
            $0.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-light")
        }
        transferLabelsCollection.forEach{
            $0.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-light")
        }
        
        biggerLabelsCollection.forEach { $0.FontStyle(fontSize: 24, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-medium")
        }
        
        countryTitle.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
        mainButton.buttonShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 15)
        mainButton.buttonFontAndSize(fontFamily: "QuickSand-semibold", fontSize: 17)
        
        countryImage.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
    }
    
    
    func getAPI(data:String){
        self.makeTransferApisAppear()
        APIServicies.getRestrictionsInfo(from: UsefulValuesFetchedFromFirebase.nationality,
                                     countryCode: "",
                                     to: data,
                                         with: UsefulValuesFetchedFromFirebase.vaccine, completion: { result in
                switch result {
                case .success(let restrictions):
                                            
                    
                    DispatchQueue.main.async{
                        
                        
                        var generalRestrictionsTransfer:APIServicies.GeneralRestricitons
                        generalRestrictionsTransfer = restrictions.generalRestricitons!
                        
                        self.transferTouristsAllowed.text = String(generalRestrictionsTransfer.allowsTourists)
                        self.transferBusinessVisits.text = String(generalRestrictionsTransfer.allowsBusinessVisit)
                        self.pCRTransfers.text = String(generalRestrictionsTransfer.pcrRequiredForResidents)
                        self.pCRNonResidentsTransfer.text = String(generalRestrictionsTransfer.pcrRequiredForNoneResidents)
                        self.covidPassportTransfer.text = String(generalRestrictionsTransfer.covidPassportRequired)
                        self.transferCountryInfo.text = String(generalRestrictionsTransfer.generalInformation)
                        
                        self.transferApiLabels.forEach{
                            $0.isTrueOrFalse()
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                }
                
            })
    }

    
}
