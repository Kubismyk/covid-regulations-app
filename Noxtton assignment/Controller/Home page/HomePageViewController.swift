//
//  HomePageViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 17.01.22.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import Firebase

struct UsefulValuesFetchedFromFirebase {
    static var username:String = "Loading..."
    static var vaccine:String = "Loading..."
    static var nationality:String = "Loading"
    static var profileImageUrl:String = ""
}

struct TestData{
    var string1:String
    var string2:String
    var image1:UIImage
}

class HomePageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    let db = Firestore.firestore()
    
    var ttest:[TestData] = [
        TestData(string1: "Georgia", string2: "Abkhazia", image1: UIImage(named: "tbilisi")!),
        TestData(string1: "Germany", string2: "Abkhazia", image1: UIImage(named: "berlin")!),
        TestData(string1: "Georgia", string2: "Abkhazia", image1: UIImage(named: "tbilisi")!)
    ]
    
    
    
    var tags:[String] = ["#Sunny","#Beach","#Snow","#Mountain","#Sea","#Rainy"]
    
    let bottomCorners:UIRectCorner =
    [.bottomLeft,.bottomRight] // apple says this gives smoother rounded corners
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var welcomeNameLabel: UILabel!
    @IBOutlet weak var whereAreYouTravellingTodayLabel: UILabel!
    
    
    @IBOutlet weak var chooseDestinationButton: UIButton!
    
    
    
    
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeNameLabel.text = "Welcome, \(UsefulValuesFetchedFromFirebase.username)"
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
        setupDesign()
        
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        HomePageViewController.getAPIs()
        
        
        NotificationCenter.default.post(name: Notification.Name("userLogged"), object: nil)
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readData()
        HomePageViewController.readSavedData()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width/2.0
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    

    // read saved countries from firestore - V
    
    static func readSavedData(){
        SavedViewController.addedToSavesArray = []
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        var db = Firestore.firestore()
        db.collection("users/\(userId)/saved").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                if let error = error {
                    print("error: \(error)")
                }
                return
            }
            for doc in snapshot.documents {
                guard let city = doc.get("city") as? String,
                      let code = doc.get("code") as? String,
                      let cImage = doc.get("countryImage") as? String,
                      let country = doc.get("country") as? String else {
                          continue // continue document loop
                      }
                var testA = [SavedCountries]()
                testA.append(SavedCountries(code: code, country: country, city: city, image: cImage))
                SavedViewController.addedToSavesArray.append(contentsOf: testA)
//                testA.uniqued()
//                print(testA)
//                if MainSheetViewController.delegate != nil {
//                    let countrySentData = country
//                    let airportSentData = city
//                    let codeSentData = code
//                    MainSheetViewController.delegate?.sendDataToSaved(savedData: SavedCountries(code: codeSentData, country: countrySentData, city: airportSentData, image: cImage))
//                }
            }
        }
    }
    
    // function to scroll tags collection automatically - V
    
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
    
    // reading user data from firebase - V

    func readData(){
        self.db.collection("users").getDocuments{ (snapshot, err) in
            
            if let err = err {
                print("error happened \(err)")
            }else {
                if let userId = Auth.auth().currentUser?.uid {
                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
                    let welcomeName = currentUserDoc["username"] as! String
                    let vaccine = currentUserDoc["vaccine"] as! String
                    let nationality = currentUserDoc["nationality"] as! String
                    let imageUrl = currentUserDoc["profileImageUrl"] as! String
                    UsefulValuesFetchedFromFirebase.username = welcomeName
                    UsefulValuesFetchedFromFirebase.vaccine = vaccine
                    UsefulValuesFetchedFromFirebase.nationality = nationality
                    UsefulValuesFetchedFromFirebase.profileImageUrl = imageUrl
                    self.welcomeNameLabel.text = "Welcome, \(welcomeName)"
                    let url = URL(string: imageUrl)
                    self.profileImageView.kf.setImage(with:url)
                    self.profileImageView.layer.masksToBounds = true
                    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
                    self.profileImageView.contentMode = .scaleToFill
                    }
                }
            }
        }
    }
    
    // fetch data from API - V
    
    static func getAPIs (){
                    APIServicies.getAirports(completion: { result in
                        switch result {
                        case .success(let airports):
                            SearchViewController.unfilteredData = []
                            SearchViewController.airportsInformation.append(contentsOf: airports.data)
                            let testData:[MixedData] = [
                                        MixedData(data: SearchViewController.airportsInformation[0], image: SearchViewController.arrayToLookCellnBackDropCooler[0]),
                                        MixedData(data: SearchViewController.airportsInformation[1], image: SearchViewController.arrayToLookCellnBackDropCooler[1]),
                                        MixedData(data: SearchViewController.airportsInformation[2], image: SearchViewController.arrayToLookCellnBackDropCooler[2]),
                                        MixedData(data: SearchViewController.airportsInformation[3], image: SearchViewController.arrayToLookCellnBackDropCooler[3]),
                                        MixedData(data: SearchViewController.airportsInformation[4], image: SearchViewController.arrayToLookCellnBackDropCooler[4]),
                                    ]
                            SearchViewController.unfilteredData.append(contentsOf: testData)
                            SearchViewController.filteredData = SearchViewController.unfilteredData
                        case .failure(let error):
                            print(error)
                        }
                        
                    })
    }
    
    
    @IBAction func chooseDestinationButtonClick(_ sender: UIButton) {
        self.tabBarController!.selectedIndex = 2
        Vibration.soft.vibrate()
    }
    
    
    var selectedCellCountry = String()
    
    
    // collection view below
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return tags.count

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            tabBarController!.selectedIndex = 2
    }
    
    func setupDesign(){
//        recommendedCollectionView.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
//        recommendedCollectionView.layer.shado
        tagsCollectionView.clipsToBounds = true
        tagsCollectionView.layer.cornerRadius = 15
        tagsCollectionView.dropShadow(shadowColor: .black, shadowX: 2, shadowY: 2, shadowOpacity: 0.25, shadowRadius: 5)
        tagsCollectionView.clipsToBounds = true
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2.0
        welcomeNameLabel.FontStyle(fontSize: 18, shadowRadius: 10, shadowOpacity: 0.5, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-bold")
        whereAreYouTravellingTodayLabel.FontStyle(fontSize: 36, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-medium")
        chooseDestinationButton.buttonShadow(shadowColor: .black, shadowX: 0, shadowY: 4, shadowOpacity: 0.25, shadowRadius: 10, cornerRadius: 9)
        chooseDestinationButton.titleLabel?.font = UIFont(name: "QuickSand-semibold", size: 20)
        
        profileImageView.dropShadow(shadowColor: .black, shadowX: 0, shadowY: 0, shadowOpacity: 0.25, shadowRadius: 10)
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor(named: "MainBlue")?.cgColor
        mainLabel.FontStyle(fontSize: 35, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-bold")
        mainLabel.textColor = UIColor(patternImage: UIImage(named: "gradient")!)
    }
}
