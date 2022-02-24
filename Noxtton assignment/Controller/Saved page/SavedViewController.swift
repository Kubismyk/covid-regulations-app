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

struct SavedCountries: Hashable {
    var code:String
    var country:String
    var city:String
    var image:String
}



class SavedViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: SavedCountries) {
        SavedViewController.addedToSavesArray.append(myData)
        self.savedItemsCollectionView.reloadData()
    }
    
    func sendDataToSaved(savedData: SavedCountries) {
        SavedViewController.addedToSavesArray.append(savedData)
        print(savedData)
    }
    
    static var addedToSavesArray = [SavedCountries]()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let secondVC: MainSheetViewController = segue.destination as! MainSheetViewController
            secondVC.delegate = self
    }
    
    

    @IBOutlet weak var savedItemsCollectionView: UICollectionView!
    
    @IBOutlet weak var mySubscribitionsLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecieved), name: .AddToSaves, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //MainSheetViewController.delegate = self
        savedItemsCollectionView.dataSource = self
        savedItemsCollectionView.delegate = self
        mySubscribitionsLabel.FontStyle(fontSize: 34, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        mySubscribitionsLabel.textColor = UIColor(patternImage: UIImage(named: "gradient")!)
        savedItemsCollectionView.reloadData()
        SavedViewController.addedToSavesArray.uniqued()
        let unique = Array(Set(SavedViewController.addedToSavesArray))
    }
    
    @objc func notificationRecieved(notification: Notification){
        savedItemsCollectionView.reloadData()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SavedViewController.addedToSavesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MySubscribitionsCollectionViewCell

        countryCell.configure(data: SavedViewController.addedToSavesArray[indexPath.row])
        
        let shadowView = UIView()
        shadowView.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
        
        shadowView.addSubview(countryCell)
        
        
        countryCell.shadowDecorate()
        countryCell.cityImage.clipsToBounds = true
        countryCell.cityImage.layer.cornerRadius = 10
        countryCell.cityImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        countryCell.cityNCountryName.FontStyle(fontSize: 25, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-bold")
        countryCell.learnMore.FontStyle(fontSize: 20, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")



        return countryCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backDropActionSheet = UIStoryboard(name: "search", bundle: nil).instantiateViewController(withIdentifier: "SheetPresentation") as! MainSheetViewController
        if let sheet = backDropActionSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
        }
        backDropActionSheet.secondConfigure(data: SavedViewController.addedToSavesArray[indexPath.row])
        
        self.present(backDropActionSheet,animated: true,completion: nil)
    }
}

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
}
