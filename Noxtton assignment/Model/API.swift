//
//  API.swift
//  Noxtton assignment
//
//  Created by Lika Zurabiani on 15.02.22.
//

import Foundation

class APIServicies {
    static func getVaccines(completion: @escaping (Result<Vaccines,Error>) -> Void) {
        guard let url = URL(string: "http://covid-restrictions-api.noxtton.com/v1/vaccine") else { return }
        APIServicies.getURL(with: url, completion: { result in
            completion(result)
        })
    }
    
    static func getNations(completion: @escaping (Result<nationalities,Error>) -> Void) {
        guard let url = URL(string: "http://covid-restrictions-api.noxtton.com/v1/nationality") else { return }
        APIServicies.getURL(with: url, completion: { result in
            completion(result)
        })
    }

    
    
    static func getAirports(completion: @escaping (Result<Airports,Error>) -> Void) {
        guard let url = URL(string: "http://covid-restrictions-api.noxtton.com/v1/airport") else { return }
        APIServicies.getURL(with: url, completion: { result in
            completion(result)
        })
    }
    
    static func getRestrictionsInfo(from country: String, countryCode: String, to airportCode: String, with vaccine: String, completion: @escaping (Result<Restrictions,Error>) -> Void) {
        let strUrl = "http://covid-restrictions-api.noxtton.com/v1/restriction/TBS/\(airportCode)?nationality=\(country)&vaccine=\(vaccine)&transfer=\(countryCode)"
        guard let url = URL(string: strUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            guard let data = data else { return }
            do {
                let dataDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                if let allRestricitons = dataDictionary["restricions"] as? [String: Any],
                    let restricitons = allRestricitons[airportCode] as? [String: Any] {
                    let restriction = Restrictions(with: restricitons)
                    completion(.success(restriction))
                }
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
    static func getURL<T: Codable>(with url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
    struct Vaccines: Codable {
        var data: [String]
        
        private enum CodingKeys: String, CodingKey {
            case data = "vaccines"
        }
    }
    
    struct nationalities: Codable {
        var data: [String]
        
        private enum CodingKeys: String, CodingKey {
            case data = "nationalities"
        }
    }
    
    struct Airports: Codable {
        var data: [Airport]
        
        private enum CodingKeys: String, CodingKey {
            case data = "airports"
        }
    }
    
    struct Airport: Codable {
        var code: String
        var country: String
        var city: String
        
        private enum CodingKeys: String, CodingKey {
            case code, country, city
        }
    }
    
    
    // MARK: - Restricitons
    struct Restrictions {
        var type: String
        var generalRestricitons: GeneralRestricitons?
        var byVaccination: RestrictionsByVaccination?
        var byNationality: RestrictionsByNationalityData?
        //var byNationality:

        
        init(with data: [String: Any]) {
            type = data["type"] as? String ?? ""
            if let general = data["generalRestrictions"] as? [String: Any] {
                generalRestricitons = GeneralRestricitons(with: general)
            }
            
            if let vaccine = data["restrictionsByVaccination"] as? [String: Any] {
                byVaccination = RestrictionsByVaccination(with: vaccine)
            }
            if let nationality = data["restrictionsByNationality"] as? [[String: Any]]{
                //nationality = RestrictionsByNationalityData(
                byNationality = RestrictionsByNationalityData(with: nationality)
            }
        }

    }
    
    struct GeneralRestricitons {
        var allowsTourists: Bool
        var allowsBusinessVisit: Bool
        var covidPassportRequired: Bool
        var pcrRequiredForNoneResidents: Bool
        var pcrRequiredForResidents: Bool
        var generalInformation: String
        
        init(with data: [String: Any]) {
            allowsTourists = data["allowsTourists"] as? Bool ?? false
            allowsBusinessVisit = data["allowsBusinessVisit"] as? Bool ?? false
            covidPassportRequired = data["covidPassportRequired"] as? Bool ?? false
            pcrRequiredForNoneResidents = data["pcrRequiredForNoneResidents"] as? Bool ?? false
            pcrRequiredForResidents = data["pcrRequiredForResidents"] as? Bool ?? false
            generalInformation = data["generalInformation"] as? String ?? ""
        }
    }
    
    struct RestrictionsByVaccination {
        var isAllowed: Bool
        var dozesRequired: Int
        var minDaysAfterVaccination: Int
        var maxDaysAfterVaccination: Int
        
        init(with data: [String: Any]) {
            isAllowed = data["isAllowed"] as? Bool ?? false
            dozesRequired = data["dozesRequired"] as? Int ?? 0
            minDaysAfterVaccination = data["minDaysAfterVaccination"] as? Int ?? 0
            maxDaysAfterVaccination = data["maxDaysAfterVaccination"] as? Int ?? 0
            
        }
    }
    struct RestrictionsByNationalityData {
            var allowsTourists: Bool?
            var allowsBusinessVisit: Bool?
            var pcrRequired: Bool?
            var fastTestRequired: Bool?
            var biometricPassportRequired: Bool?
            var locatorFormRequired: Bool?
            var covidPassportRequired: Bool?
            
            enum types: String {
                case visit = "Visit Type"
                case covidTest = "Covid Test"
                case documentsRequired = "Documents Required"
            }
            
            init(with datas: [[String: Any]]) {
                for data in datas {
                    guard let restrictionType = data["type"]  as? String,
                          let restrictionData = data["data"] as? [String: Bool] else { return }
                   
                    if restrictionType == types.visit.rawValue {
                        allowsTourists = restrictionData["allowsTourists"] ?? false
                        allowsBusinessVisit = restrictionData["allowsBusinessVisit"] ?? false
                    } else if restrictionType == types.covidTest.rawValue {
                        pcrRequired = restrictionData["pcrRequired"] ?? false
                        fastTestRequired = restrictionData["fastTestRequired"] ?? false
                    } else if restrictionType == types.documentsRequired.rawValue {
                        biometricPassportRequired = restrictionData["biometricPassportRequired"] ?? false
                        locatorFormRequired = restrictionData["locatorFormRequired"] ?? false
                        covidPassportRequired = restrictionData["covidPassportRequired"] ?? false
                    }
                }
            }
        }

}



//        DispatchQueue.main.async {
//                    APIServicies.getVaccines(completion: { [weak self] result in
//                        switch result {
//                        case .success(let vaccines):
//                            print(vaccines.data)
//
//                        case .failure(let error):
//                            print(error)
//                        }
//
//                    })
//                }
//
//                DispatchQueue.main.async {
//                    APIServicies.getNations(completion: { result in
//                        switch result {
//                        case .success(let nations):
//                            print("o")
//                        case .failure(let error):
//                            print(error)
//                        }
//
//                    })
//                }
//
//                DispatchQueue.main.async {
//                    APIServicies.getAirports(completion: { result in
//                        switch result {
//                        case .success(let airports):
//                            self.airportsInformation.append(contentsOf: airports.data)
//                        case .failure(let error):
//                            print(error)
//                        }
//
//                    })
//                }
//        DispatchQueue.main.async {
//            APIServicies.getRestrictionsInfo(from: usefulValuesFetchedFromFirebase.nationality,
//                                                     countryCode: "BER",
//                                                     to: "RIX",
//                                                     with: usefulValuesFetchedFromFirebase.vaccine, completion: {result in
//                        switch result {
//                        case .success(let restrictions):
//                            //print(restrictions)
//                            print("o")
//                        case .failure(let error):
//                            print(error)
//                        }
//
//                    })
//
//                }
