//
//  HomePageViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 17.01.22.
//

import UIKit
import Shuffle

struct swipeCardData {
    var mainImage: UIImage
    var countryName: String
}

class HomePageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SwipeCardStackDataSource,SwipeCardStackDelegate  {
    
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return card1(index: array1[index])
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return array1.count
    }
    
    let cardStack = SwipeCardStack()
    
    var array1:[swipeCardData] = [
        swipeCardData(mainImage: UIImage(named: "tbtbtb")!, countryName: "Georgia"),
        swipeCardData(mainImage: UIImage(named: "tbtbtb")!, countryName: "Finland"),
        swipeCardData(mainImage: UIImage(named: "tbtbtb")!, countryName: "Russia")
    ]
    
    
    
    
    var tags:[String] = ["#Sunny","#Beach","#Snow","#Mountain","#Sea"]
    
    
    let bottomCorners:UIRectCorner =
    [.bottomLeft,.bottomRight] // apple says this gives smoother rounded corners
    
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
        
        view.addSubview(cardStack)
        cardStack.dataSource = self
        cardStack.delegate = self
        cardStack.frame = destinationBox.frame
        
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.clipsToBounds = true
        tagsCollectionView.layer.cornerRadius = 15
        tagsCollectionView.dropShadow(shadowColor: .black, shadowX: 2, shadowY: 2, shadowOpacity: 0.25, shadowRadius: 5)
        tagsCollectionView.clipsToBounds = true
        
        

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
    
    
    
    
    @IBAction func chooseDestinationButtonClick(_ sender: UIButton) {
        self.tabBarController!.selectedIndex = 3 - 1
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
    
    
    func card1(index: swipeCardData) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right, .up]
        card.layer.cornerRadius = 12
        card.roundCorners(bottomCorners, radius: 58)
        card.layer.shadowOffset = CGSize.zero
        card.layer.shadowOpacity = 1.0
        card.layer.shadowRadius = 6.0
        card.layer.masksToBounds =  true
        //card.layer.borderWidth = 2
        
        let view_bg = UIView(frame: CGRect(x: 0, y: 0, width: destinationBox.frame.size.width, height: destinationBox.frame.height))
        card.content = view_bg
        view_bg.layer.cornerRadius = 12
        view_bg.clipsToBounds = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            
            let view_bg1 = UIView(frame: CGRect(x: 0, y: 0, width: view_bg.frame.size.width, height: view_bg.frame.size.height))
            
            view_bg.backgroundColor = UIColor(named: "InnerShadowPurple")
            card.content?.addSubview(view_bg1)
            
            let img_card_type = UIImageView(frame: CGRect.zero)
            img_card_type.contentMode = .scaleAspectFit
            img_card_type.translatesAutoresizingMaskIntoConstraints = false
            img_card_type.isHidden = true
            view_bg1.addSubview(img_card_type)
            img_card_type.centerXAnchor.constraint(equalToSystemSpacingAfter: view_bg1.centerXAnchor, multiplier: 1).isActive = true
            img_card_type.topAnchor.constraint(equalTo: view_bg1.topAnchor, constant: 0).isActive = true
            img_card_type.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            
            let img_comapny = UIImageView(frame: CGRect(x: 24, y: 24, width: view_bg.frame.size.width, height: 100))
            img_comapny.image = index.mainImage
            img_comapny.translatesAutoresizingMaskIntoConstraints = false
            //img_comapny.layer.cornerRadius = 50
        
            img_comapny.layer.shadowOffset = CGSize.zero
            img_comapny.layer.shadowOpacity = 1.0
            img_comapny.layer.shadowRadius = 6.0
            img_comapny.layer.masksToBounds =  false
            img_comapny.clipsToBounds = true
            view_bg1.addSubview(img_comapny)
            img_comapny.topAnchor.constraint(equalTo: img_card_type.bottomAnchor, constant: 0).isActive = true
            img_comapny.leadingAnchor.constraint(equalTo: view_bg1.leadingAnchor, constant: 0).isActive = true
            img_comapny.heightAnchor.constraint(equalToConstant: view_bg1.frame.size.height - 70).isActive = true
            img_comapny.widthAnchor.constraint(equalToConstant: view_bg1.frame.size.width).isActive = true
            
            
            let countryName = UILabel(frame: CGRect.zero)
            countryName.text = index.countryName
            //countryName.font = countryName.font.withSize(25)
            countryName.FontStyle(fontSize: 30, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 0, shadowY: 0, fontFamily: "QuickSand-bold")
            countryName.textColor = .white
            countryName.translatesAutoresizingMaskIntoConstraints = false
            countryName.numberOfLines = 0
            view_bg1.addSubview(countryName)
            countryName.topAnchor.constraint(equalTo: img_comapny.bottomAnchor, constant: 15).isActive = true
            countryName.leadingAnchor.constraint(equalTo: view_bg1.leadingAnchor, constant: 34).isActive = true
            countryName.trailingAnchor.constraint(equalTo: view_bg1.trailingAnchor, constant: -24).isActive = true
            
        }
        let leftOverlay = UIImageView()
        let img_dislike = UIImageView(frame: CGRect(x: view_bg.frame.size.width - 132, y: 32, width: 100, height: 100))
        img_dislike.image = UIImage(named: "dislike")
        leftOverlay.addSubview(img_dislike)
        
        let rightOverlay = UIView()
        let img_like = UIImageView(frame: CGRect(x: 32, y: 32, width: 100, height: 100))
        img_like.image = UIImage(named: "Image")
        rightOverlay.addSubview(img_like)
        
        let upOverlay = UIView()
        let img_saved = UIImageView(frame: CGRect(x: (view_bg.frame.size.width - 100)/2, y: (view_bg.frame.size.height)/2, width: 100, height: 100))
        img_saved.image = UIImage(named: "ic_save")
        upOverlay.addSubview(img_saved)
        
        card.setOverlays([.left: leftOverlay, .right: rightOverlay, .up: upOverlay])
        return card
    }
        
        
        

        func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int){
            print("selected card")
        }
        func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection){
            print("a")
        }
        func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
            print("b")
        }
        func didSwipeAllCards(_ cardStack: SwipeCardStack){
            print("hell")
        }

}
