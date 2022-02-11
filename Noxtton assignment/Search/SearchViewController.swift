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
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Georgia is located between Asia and Europe and occupies a land area of 69,700 square kilometres, bordered by the Black Sea to the west, Turkey to the southwest, Azerbaijan to the east, Russia to the north, and Armenia to the south. ... Georgian is the official language of Georgia, and it is spoken by 71% of the population.", image: UIImage(named: "tbtbtb")!),        SearchCollectionViewData(header: "Finlad,Geneva Airport", information: "Georgia is located between Asia and Europe and occupies a land area of 69,700 square kilometres, bordered by the Black Sea to the west, Turkey to the southwest, Azerbaijan to the east, Russia to the north, and Armenia to the south. ... Georgian is the official language of Georgia, and it is spoken by 71% of the population.", image: UIImage(named: "tbtbtb")!)
    ]

    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! searchCollectionViewCell
            cell.config(data: array2[indexPath.row])
            cell.headerTitle.FontStyle(fontSize: 26, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand")
            cell.infoLabel.FontStyle(fontSize: 14, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-light")

            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width - 350, height: collectionView.frame.size.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        let backDropActionSheet = UIStoryboard(name: "search", bundle: nil).instantiateViewController(withIdentifier: "SheetPresentation") as! MainSheetViewController
        if let sheet = backDropActionSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
        }
        backDropActionSheet.configure(with: array2[indexPath.row])
        
        self.present(backDropActionSheet,animated: true,completion: nil)
    }
    @IBAction func likeButton(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
    }
}
