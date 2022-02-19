//
//  LocationViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 17.02.22.
//

import UIKit

protocol LocationDataSentToRegisterViewControllerProtocol {
    func sendLocationDataToFirstViewController(myData: String)
}

class LocationViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    

    @IBOutlet var labelsCollection: [UILabel]!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    static var locationData:[String] = ["loading"]
    
    var delegate: LocationDataSentToRegisterViewControllerProtocol? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        
        viewDesign()
        locationCollectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        locationCollectionView.reloadData()
    }
    
    
    
    
    


    private func viewDesign() {
        labelsCollection.forEach {
            $0.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-light")
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        LocationViewController.locationData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let locationCell = collectionView.dequeueReusableCell(withReuseIdentifier: "locationCell", for: indexPath) as! LocationCollectionViewCell
        locationCell.isUserInteractionEnabled = true
        locationCell.layer.cornerRadius = 7
        locationCell.locationString.text = LocationViewController.locationData[indexPath.row] // vaccine names from API
        return locationCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedLocation = LocationViewController.locationData[indexPath.row]
        Vibration.soft.vibrate()
        
        if self.delegate != nil {
            self.delegate?.sendLocationDataToFirstViewController(myData: selectedLocation)
            dismiss(animated: true, completion: nil)
        }
    }
    

}
