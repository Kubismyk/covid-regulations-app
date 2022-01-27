//
//  SavedViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 22.01.22.
//

import UIKit


struct SubscribitionCollectionViewStructure {
    var cityImage: UIImage
    var CityNCountryName: String
}

var array1:[SubscribitionCollectionViewStructure] = [
    SubscribitionCollectionViewStructure(cityImage: UIImage(named: "tbtbtb")!, CityNCountryName: "Tbilisi/Georgia"),SubscribitionCollectionViewStructure(cityImage: UIImage(named: "tbtbtb")!, CityNCountryName: "Switzerland/asdd"),SubscribitionCollectionViewStructure(cityImage: UIImage(named: "tbtbtb")!, CityNCountryName: "Switzerland/asdd")
]




class SavedViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var savedItemsCollectionView: UICollectionView!
    
    @IBOutlet weak var mySubscribitionsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        savedItemsCollectionView.dataSource = self
        savedItemsCollectionView.delegate = self
        mySubscribitionsLabel.FontStyle(fontSize: 34, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "Quicksand-bold")
        mySubscribitionsLabel.textColor = UIColor(patternImage: UIImage(named: "gradient")!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MySubscribitionsCollectionViewCell
        countryCell.configure(with: array1[indexPath.row])
        //countryCell.dropShadow(shadowColor: .purple, shadowX: 2, shadowY: 2, shadowOpacity: 0.25, shadowRadius: 10)
        
        countryCell.layer.cornerRadius = 10
        countryCell.layer.borderWidth = 1.0
        countryCell.layer.borderColor = UIColor.lightGray.cgColor

        countryCell.layer.backgroundColor = UIColor.white.cgColor
        countryCell.layer.shadowColor = UIColor.gray.cgColor
        countryCell.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        countryCell.layer.shadowRadius = 10.0
        countryCell.layer.shadowOpacity = 0.5
        countryCell.cityImage.clipsToBounds = true
        countryCell.cityImage.layer.cornerRadius = 10
        countryCell.cityImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        countryCell.cityNCountryName.FontStyle(fontSize: 25, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-bold")
        countryCell.learnMore.FontStyle(fontSize: 20, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
        countryCell.layer.cornerRadius = 10
        countryCell.layer.borderWidth = 1.0

        countryCell.layer.borderColor = UIColor.clear.cgColor
        //countryCell.layer.masksToBounds = true


        return countryCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }
}
