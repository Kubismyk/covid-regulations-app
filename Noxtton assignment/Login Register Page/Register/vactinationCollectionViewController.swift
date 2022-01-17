//
//  vactinationCollectionViewController.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 16.01.22.
//

import UIKit

class vactinationCollectionViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var vaccinesData:[String] = ["Moderna","Pfyzer","lorem","space","ipsum","Sinovac","asdasdasdas dasdasdasd sadasd","Sinofarm","J&J"]
    
    @IBOutlet weak var mainText: UILabel!
    
    @IBOutlet weak var whichVaccineLabel: UILabel!
    @IBOutlet weak var vaccinesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainDesign()
        
        vaccinesCollectionView.dataSource = self
        vaccinesCollectionView.delegate = self
    }
    
    // design below
    
    private func mainDesign(){
        mainText.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-light")
        whichVaccineLabel.FontStyle(fontSize: 17, shadowRadius: 10, shadowOpacity: 0.25, shadowX: 2, shadowY: 2, fontFamily: "QuickSand-light")
    }
    
    
    // collection view below
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vaccinesData.count  // number of items in the vaccine API
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vaccineCell = collectionView.dequeueReusableCell(withReuseIdentifier: "vaccine", for: indexPath) as! VaccinesCollectionViewCell

        vaccineCell.layer.cornerRadius = 7
        vaccineCell.vaccineButton.setTitle(vaccinesData[indexPath.row], for: .normal) // vaccine names from API
        return vaccineCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    @IBAction func notVaccinated(_ sender: Any) {
        // denying vactination action here
        print("denying vactination action here")
    }
}