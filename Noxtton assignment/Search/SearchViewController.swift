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
struct mixedData {
    var country:String
    var code:String
    var city:String
    var image:UIImage
    var info:String
    init(data:APIServicies.Airport, image:SearchCollectionViewData){
        self.country = data.country
        self.code = data.code
        self.info = image.information
        self.city = data.city
        self.image = image.image
    }
}
class SearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    static var arrayToLookCellnBackDropCooler:[SearchCollectionViewData] = [
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Before visiting Georgia you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "tbilisi")!),        SearchCollectionViewData(header: "Latvia,Riga", information: "Before visiting Latvia you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "riga")!),
        SearchCollectionViewData(header: "Estonia,Talini Airport", information: "Before visiting Estonia you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "talinn")!),
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Before visiting Germany you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "berlin")!),
        SearchCollectionViewData(header: "Georgia,Tbilisi Airport", information: "Before visiting Switzerland you may need to get the following vaccinations or take the following precautions. It is best to seek medical advice as your individual health and your planned activities will be a factor. Seek advice 4-6 weeks before travel.", image: UIImage(named: "geneva")!)
    ]
    

    
    static var airportsInformation = [APIServicies.Airport]()
    
    static var unfilteredData = [mixedData]()
    static var filteredData = [mixedData]()
    
    


    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! searchCollectionViewCell
            cell.config(data: SearchViewController.filteredData[indexPath.row])
            cell.headerTitle.FontStyle(fontSize: 26, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand")
            cell.infoLabel.FontStyle(fontSize: 14, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-light")
        // cell design
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchViewController.filteredData.count
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
        backDropActionSheet.configWith(data: SearchViewController.filteredData[indexPath.row])
        self.present(backDropActionSheet,animated: true,completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchViewController.filteredData = [mixedData]()
        for country in SearchViewController.unfilteredData {
            if country.country.uppercased().contains(searchText.uppercased()) {
                SearchViewController.filteredData.append(country)
            }
        }
        if searchText == "" {
            SearchViewController.filteredData = [mixedData]()
            SearchViewController.filteredData = SearchViewController.unfilteredData
        }
        self.collectionView.reloadData()
    }
}
