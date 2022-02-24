//
//  MySubscribitionsCollectionViewCell.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 23.01.22.
//

import UIKit
import Kingfisher

class MySubscribitionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNCountryName: UILabel!
    @IBOutlet weak var learnMore: UILabel!
    
    func configure(data:SavedCountries){
        let url = URL(string: data.image)
        self.cityImage.kf.setImage(with:url)
        cityNCountryName.text = data.country + "," + data.city
    }
}
