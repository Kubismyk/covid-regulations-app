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
    
    
    var arrayToLookCellnBackDropCooler:[SearchCollectionViewData] = [
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Before visiting Georgia you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "tbilisi")!),        SearchCollectionViewData(header: "Latvia,Riga", information: "Before visiting Germany you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "riga")!),
        SearchCollectionViewData(header: "Estonia,Talini Airport", information: "Before visiting Germany you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "talinn")!),
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Before visiting Germany you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "berlin")!),
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Before visiting Germany you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "geneva")!)
    ]
    
    var airportsInformation = [APIServicies.Airport]()
    var filteredData = [String]()
    
    


    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        getAPI()
        //collectionView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("help")
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.reloadData()
    }
    private func getAPI (){
                    APIServicies.getAirports(completion: { result in
                        switch result {
                        case .success(let airports):
                            self.airportsInformation.append(contentsOf: airports.data)
                        case .failure(let error):
                            print(error)
                        }
                        
                    })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! searchCollectionViewCell
            cell.config(data: arrayToLookCellnBackDropCooler[indexPath.row],dataTwo: airportsInformation[indexPath.row])
            cell.headerTitle.FontStyle(fontSize: 26, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand")
            cell.infoLabel.FontStyle(fontSize: 14, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-light")
            cell.countryImage.image = arrayToLookCellnBackDropCooler[indexPath.row].image
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return airportsInformation.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width - 350, height: collectionView.frame.size.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backDropActionSheet = UIStoryboard(name: "search", bundle: nil).instantiateViewController(withIdentifier: "SheetPresentation") as! MainSheetViewController
        if let sheet = backDropActionSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
        }
        backDropActionSheet.configure(data: arrayToLookCellnBackDropCooler[indexPath.row],dataTwo: airportsInformation[indexPath.row])
        self.present(backDropActionSheet,animated: true,completion: nil)
    }
    @IBAction func likeButton(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
    }
}
