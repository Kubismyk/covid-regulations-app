//
//  GuestSearchViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 21.02.22.
//

import UIKit

class GuestSearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        searchBar.delegate = self
        HomePageViewController.getAPIs()

    }

    
    @IBAction func backButton(_ sender: Any) {
        Vibration.soft.vibrate()
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchViewController.unfilteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seachGuest", for: indexPath) as! GuestSearchCollectionViewCell
        cell.config(data: SearchViewController.unfilteredData[indexPath.row])
//            cell.countryName.FontStyle(fontSize: 26, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand")
//            cell.countryInfo.FontStyle(fontSize: 14, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 4, shadowY: 4, fontFamily: "QuickSand-light")
        // cell design
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backDropActionSheet = UIStoryboard(name: "Guest", bundle: nil).instantiateViewController(withIdentifier: "GuestMainSheetViewController") as! GuestMainSheetViewController
        if let sheet = backDropActionSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
        }
        backDropActionSheet.configWith(data: SearchViewController.unfilteredData[indexPath.row])
        self.present(backDropActionSheet,animated: true,completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchViewController.filteredData = [MixedData]()
        for country in SearchViewController.unfilteredData {
            if country.country.uppercased().contains(searchText.uppercased()) {
                SearchViewController.filteredData.append(country)
            }
        }
        if searchText == "" {
            SearchViewController.filteredData = [MixedData]()
            SearchViewController.filteredData = SearchViewController.unfilteredData
        }
        self.collectionView.reloadData()
    }

}
