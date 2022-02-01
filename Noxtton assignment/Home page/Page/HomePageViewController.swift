//
//  HomePageViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 17.01.22.
//

import UIKit
import Hero

class HomePageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    lazy var greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    
    var tags:[String] = ["#Sunny","#Beach","#Snow","#Mountain","#Sea"]
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var welcomeNameLabel: UILabel!
    @IBOutlet weak var whereAreYouTravellingTodayLabel: UILabel!
    
    
    @IBOutlet weak var chooseDestinationButton: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    
    
    
    @IBOutlet weak var destinationBox: UIView!
    
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.clipsToBounds = true
        tagsCollectionView.layer.cornerRadius = 15
        tagsCollectionView.dropShadow(shadowColor: .black, shadowX: 2, shadowY: 2, shadowOpacity: 0.25, shadowRadius: 5)
        tagsCollectionView.clipsToBounds = true
        
        
        let bottomCorners:UIRectCorner =
        [.bottomLeft,.bottomRight] // apple says this gives smoother rounded corners

        destinationBox.roundCorners(bottomCorners, radius: 58)
        destinationBox.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 7)
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2.0
        welcomeNameLabel.FontStyle(fontSize: 18, shadowRadius: 10, shadowOpacity: 0.5, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-bold")
        whereAreYouTravellingTodayLabel.FontStyle(fontSize: 36, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-medium")
        chooseDestinationButton.buttonShadow(shadowColor: .black, shadowX: 0, shadowY: 4, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 9)
        //chooseDestinationButton.buttonFontAndSize(fontFamily: "QuickSand", fontSize: 18)
        chooseDestinationButton.titleLabel?.font = UIFont(name: "QuickSand-semibold", size: 20)
    }
    // collection view below
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count  // number of items in the vaccine API
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagsID", for: indexPath) as! TagsCollectionViewCell
        tagsCell.tagsLabel.text = tags[indexPath.row]
        tagsCell.layer.cornerRadius = 15
        //tagsCell.tag
        tagsCell.tagsLabel.FontStyle(fontSize: 15, shadowRadius: 2, shadowOpacity: 0, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        tagsCell.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.5, shadowRadius: 10)
        return tagsCell
    }
    

    
    @objc func scrollAutomatically(_ timer1: Timer) {
           
           if let coll  = tagsCollectionView {
               for cell in coll.visibleCells {
                   let indexPath: IndexPath? = coll.indexPath(for: cell)
                   if ((indexPath?.row)!  < tags.count - 1){
                       let indexPath1: IndexPath?
                       indexPath1 = IndexPath.init(row: (indexPath?.row)! + Int(1), section: (indexPath?.section)!)
                       
                       coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                   }
                   else{
                       let indexPath1: IndexPath?
                       indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                       coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                   }
                   
               }
           }
           
       }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let noOfCellsInRow = 3
//
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//
//        let totalSpace = flowLayout.sectionInset.left
//            + flowLayout.sectionInset.right
//            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
//
//        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
//
//        return CGSize(width: size, height: size)
//    }

}
