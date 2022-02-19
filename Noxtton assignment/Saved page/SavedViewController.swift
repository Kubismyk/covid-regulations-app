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

var savedArray:[SearchCollectionViewData] = [SearchCollectionViewData(header: "asd", information: "basd", image: UIImage(named:"tbtbtb")!)]



class SavedViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var savedItemsCollectionView: UICollectionView!
    
    @IBOutlet weak var mySubscribitionsLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecieved), name: .AddToSaves, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        savedItemsCollectionView.dataSource = self
        savedItemsCollectionView.delegate = self
        mySubscribitionsLabel.FontStyle(fontSize: 34, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        mySubscribitionsLabel.textColor = UIColor(patternImage: UIImage(named: "gradient")!)
        savedItemsCollectionView.reloadData()
        
    }
    
    @objc func notificationRecieved(notification: Notification){
        guard let userInfo = notification.userInfo,
              let header = userInfo["header"] as? String,
              let infoLabel = userInfo["infoLabel"] as? String,
              let image = userInfo["image"] as? UIImage else { return }
        let receivedData = SearchCollectionViewData(header: header, information: infoLabel, image: image)
        savedArray.append(receivedData)
        savedItemsCollectionView.reloadData()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MySubscribitionsCollectionViewCell
        countryCell.configure(with: savedArray[indexPath.row])
        
//        let shadowView = UIView()
//        shadowView.layer.masksToBounds = false
////        countryCell.layer.cornerRadius = 10
////        countryCell.layer.borderWidth = 1.0
//        shadowView.layer.borderColor = UIColor.lightGray.cgColor
//        shadowView.layer.backgroundColor = UIColor.white.cgColor
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
//        shadowView.layer.shadowRadius = 10.0
//        shadowView.layer.shadowOpacity = 0.25
//
//        let mainView = UIView()
//        mainView.layer.cornerRadius = 10
//        mainView.layer.masksToBounds = true
//
//        shadowView.addSubview(mainView)
        let shadowView = UIView()
        shadowView.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
        
        shadowView.addSubview(countryCell)
        
        
        countryCell.shadowDecorate()
        countryCell.cityImage.clipsToBounds = true
        //countryCell.cityImage.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
        countryCell.cityImage.layer.cornerRadius = 10
        countryCell.cityImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        countryCell.cityNCountryName.FontStyle(fontSize: 25, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-bold")
        countryCell.learnMore.FontStyle(fontSize: 20, shadowRadius: 5, shadowOpacity: 0.25, shadowX: 2, shadowY: 0, fontFamily: "QuickSand-semibold")
//        countryCell.layer.cornerRadius = 10
//        countryCell.layer.borderWidth = 1.0
//        countryCell.layer.borderColor = UIColor.clear.cgColor
        //countryCell.layer.masksToBounds = true


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
        //backDropActionSheet.configure(with: savedArray[indexPath.row])
        
        self.present(backDropActionSheet,animated: true,completion: nil)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width - 300, height: collectionView.frame.size.height/2)
//    }
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
