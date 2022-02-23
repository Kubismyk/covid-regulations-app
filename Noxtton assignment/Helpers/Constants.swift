//
//  Constants.swift
//  loginfirebase
//
//  Created by Levan Charuashvili on 12.02.22.
//

import Foundation


struct Constants {
    struct Storyboard {
        static let loggedViewController = "HomePageID"
        static let logInViewController = "firstNavigationController"
    }
}
protocol savedDataSendingDelegateProtocolo{
    func sendDataToSaved(savedData:SavedCountries)
}
