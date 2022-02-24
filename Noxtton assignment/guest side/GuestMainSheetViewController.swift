//
//  GuestMainSheetViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 22.02.22.
//

import UIKit

class GuestMainSheetViewController: UIViewController {
    @IBOutlet var fixedLabelsCollections: [UILabel]!
    
    @IBOutlet weak var generalRestrictions: UILabel!
    @IBOutlet var apiLabels: [UILabel]!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryText: UILabel!
    @IBOutlet weak var cityText: UILabel!
    //
    @IBOutlet weak var allowTourists: UILabel!
    @IBOutlet weak var businessVisits: UILabel!
    @IBOutlet weak var covidPassRequired: UILabel!
    @IBOutlet weak var nonResidents: UILabel!
    @IBOutlet weak var residents: UILabel!
    @IBOutlet weak var mainInfo: UILabel!
    
    var country:String = ""
    var city:String = ""
    var code:String = ""
    var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryText.text = country
        self.cityText.text = city
        self.countryImage.image = image
        setupDesign()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //getAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAPI()
    }
    
    
    
    func configWith(data:MixedData) {
        self.image = data.image
        self.country = data.country
        self.city = data.city
        self.code = data.code
    }
    
    private func getAPI(){
        APIServicies.getRestrictionsInfo(from: "",
                                     countryCode: "",
                                         to: self.code,
                                         with: "", completion: { result in
                switch result {
                case .success(let restrictions):
                                            
                    print(restrictions)
                    DispatchQueue.main.async{
                        
                        
                        var generalRestrictionsTransfer:APIServicies.GeneralRestricitons
                        generalRestrictionsTransfer = restrictions.generalRestricitons!
                        
                        self.allowTourists.text = String(generalRestrictionsTransfer.allowsTourists)
                        self.businessVisits.text = String(generalRestrictionsTransfer.allowsBusinessVisit)
                        self.covidPassRequired.text = String(generalRestrictionsTransfer.pcrRequiredForResidents)
                        self.nonResidents.text = String(generalRestrictionsTransfer.pcrRequiredForNoneResidents)
                        self.residents.text = String(generalRestrictionsTransfer.covidPassportRequired)
                        self.mainInfo.text = String(generalRestrictionsTransfer.generalInformation)

                        self.apiLabels.forEach{
                            $0.isTrueOrFalse()
                        }
                        
                    }
                case .failure(let error):
                    print("error : \(error)")
                }
                
            })
    }
    
    
    
    
    func setupDesign(){
        apiLabels.forEach {
            $0.FontStyle(fontSize: 16, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-semibold")
        }
        countryText.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
        cityText.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
        fixedLabelsCollections.forEach {
            $0.FontStyle(fontSize: 16, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-light")
        }
        generalRestrictions.FontStyle(fontSize: 24, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-medium")
    }
    


}
