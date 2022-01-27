//
//  MySubscribitionsCollectionViewCell.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 23.01.22.
//

import UIKit

class MySubscribitionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNCountryName: UILabel!
    @IBOutlet weak var learnMore: UILabel!
    
    func configure(with items:SubscribitionCollectionViewStructure){
        cityImage.image = items.cityImage
        cityNCountryName.text = items.CityNCountryName
    }
}
