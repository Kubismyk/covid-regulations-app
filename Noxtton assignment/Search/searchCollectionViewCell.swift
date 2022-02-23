//
//  searchCollectionViewCell.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 30.01.22.
//

import UIKit

class searchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    func config(data:mixedData){
        self.headerTitle.text = data.country + "," + data.city + " airport"
        self.infoLabel.text = data.info
    }
}
