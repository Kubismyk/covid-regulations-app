//
//  MainSheetViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 06.02.22.
//

import UIKit


class MainSheetViewController: UIViewController {
    

    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        self.countryTitle.text = a
        self.airport.text = b
        self.countryImage.image = self.cityImage.image
        setUpEveryThing()
        apiLabels.forEach {
            $0.FontStyle(fontSize: 16, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-semibold")
        }
        myNationalityLabel.text = usefulValuesFetchedFromFirebase.nationality
        myNationalityLabel.FontStyle(fontSize: 17, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        myVaccineLabel.text = usefulValuesFetchedFromFirebase.vaccine
        myVaccineLabel.FontStyle(fontSize: 17, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        myNationalityText.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
        myVaccineText.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
    }
    
    
    func setUpEveryThing(){
        self.generalInfoLabel.text! = generalInfo
        APIServicies.getRestrictionsInfo(from: usefulValuesFetchedFromFirebase.nationality,
                                                 countryCode: "",
                                         to: self.info,
                                         with: usefulValuesFetchedFromFirebase.vaccine, completion: { result in
                    switch result {
                    case .success(let restrictions):
                        
                        var generalRestrictions:APIServicies.GeneralRestricitons
                        generalRestrictions = restrictions.generalRestricitons!
                        
                        var vaccinationRestrictions:APIServicies.RestrictionsByVaccination
                        vaccinationRestrictions = restrictions.byVaccination!
                        
                        var nationalityRestrictions:APIServicies.RestrictionsByNationalityData
                        //nationalityRestrictions = restrictions.byNationality!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)


    }
    var cityImage = UIImageView()
    
    
    func configure(data:SearchCollectionViewData, dataTwo:APIServicies.Airport){
        self.cityImage.image = data.image
        self.a = dataTwo.country
        self.b = dataTwo.city
        self.info = dataTwo.code
    }
    func setupDesign(){
        labelsCollection.forEach {
            $0.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-light")
        }

        biggerLabelsCollection.forEach { $0.FontStyle(fontSize: 24, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-medium")
        }
        
        countryTitle.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
        mainButton.buttonShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 15)
        mainButton.buttonFontAndSize(fontFamily: "QuickSand-semibold", fontSize: 17)
        
        countryImage.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
    }
    
    
}
