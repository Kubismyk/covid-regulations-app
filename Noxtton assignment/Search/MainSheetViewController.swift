//
//  MainSheetViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 06.02.22.
//

import UIKit

class MainSheetViewController: UIViewController {

    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    var info:String = ""
    var a:String = ""
    var d:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        self.countryTitle.text = a
    }
    
    
    func configure(with data:SearchCollectionViewData){
        //countryImage.image = data.image
        //countryTitle.text = data.header
        a = data.header
        d = data.information
        //countryTitle.text = data.header
        //self.info = data.information
    }
    func setupDesign(){
        countryTitle.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-semibold")
        mainButton.buttonShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 15)
        mainButton.buttonFontAndSize(fontFamily: "QuickSand-semibold", fontSize: 17)
        
        countryImage.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
    }


}
