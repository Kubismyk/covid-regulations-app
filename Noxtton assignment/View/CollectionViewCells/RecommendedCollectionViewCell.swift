//
//  RecommendedCollectionViewCell.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 23.02.22.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var city: UILabel!
    
    func config(data:TestData){
//        self.countryImage.image = data.image
//        self.country.text = data.country
//        self.city.text = data.city
        self.country.text = data.string1
        self.city.text = data.string2
        self.countryImage.image = data.image1
    }
    
}
