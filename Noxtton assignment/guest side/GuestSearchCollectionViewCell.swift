//
//  GuestSearchCollectionViewCell.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 21.02.22.
//

import UIKit

class GuestSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryInfo: UILabel!
    
    func config(data:MixedData){
        self.countryName.text = data.country + "," + data.city + " airport"
        self.countryInfo.text = data.info
    }
}
