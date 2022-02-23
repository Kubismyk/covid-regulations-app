//
//  GuestMainSheetViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 22.02.22.
//

import UIKit

class GuestMainSheetViewController: UIViewController {

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
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //getAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAPI()
    }
    
    
    
    func configWith(data:mixedData) {
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
//
//                        self.transferApiLabels.forEach{
//                            $0.isTrueOrFalse()
//                        }
                        
                    }
                case .failure(let error):
                    print("error : \(error)")
                }
                
            })
    }
    


}
