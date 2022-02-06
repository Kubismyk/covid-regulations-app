//
//  SearchViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 29.01.22.
//

import UIKit

struct SearchCollectionViewData {
    var header:String
    var information:String
    var image:UIImage
}

class SearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var array2:[SearchCollectionViewData] = [
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Georgia is located between Asia and Europe and occupies a land area of 69,700 square kilometres, bordered by the Black Sea to the west, Turkey to the southwest, Azerbaijan to the east, Russia to the north, and Armenia to the south. ... Georgian is the official language of Georgia, and it is spoken by 71% of the population.", image: UIImage(named: "tbtbtb")!),        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Georgia is located between Asia and Europe and occupies a land area of 69,700 square kilometres, bordered by the Black Sea to the west, Turkey to the southwest, Azerbaijan to the east, Russia to the north, and Armenia to the south. ... Georgian is the official language of Georgia, and it is spoken by 71% of the population.", image: UIImage(named: "tbtbtb")!)
    ]

    

    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
//        recommendedCollectionView.dataSource = self
//        recommendedCollectionView.delegate = self
//        recommendedCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! searchCollectionViewCell
            cell.config(data: array2[indexPath.row])
            cell.headerTitle.FontStyle(fontSize: 26, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand")
            //cell.countryImage.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
            //cell.countryImage.dropShadow(shadowColor: .white, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
            //cell.countryImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.infoLabel.FontStyle(fontSize: 14, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-light")

            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }
//        else {
//        let recommendedCell = recommendedCollectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! recommendedCollectionViewCell
//            recommendedCell.recImage.image = UIImage(named: "tbtbtb")!
//            recommendedCell.recName.text = "tbilisi"
//            recommendedCell.layer.masksToBounds = true
//            recommendedCell.layer.cornerRadius = 9
//            recommendedCell.alpha = 0.5
//            recommendedCell.recImage.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
//            recommendedCell.recImage.dropShadow(shadowColor: .white, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
//            recommendedCell.dropShadow(shadowColor: .black, shadowX: 2, shadowY: 2, shadowOpacity: 0.25, shadowRadius: 10)
//            return recommendedCell
//        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width - 350, height: collectionView.frame.size.height/2)

    }
}
