//
//  Networking.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

enum NetworkError:Error{
    case URLDoesNotConnect
    case NoData
    case NoImage
}

class Networking{
    static let imageURLBase = "https://raw.githubusercontent.com/kendellm/SWAPI/master/"
    static let rootURL = "https://swapi.co/api/"
    
    class func getAPI(_ url:URL,_ objectList:ObjectListType,_ object:ObjectType, completion: @escaping (Any?,Error?)->()){
        let session = URLSession.shared
        
        session.dataTask(with: url){
            (data, response, error) in
            guard error == nil else{
                completion(nil, error)
                return
            }
            guard let data = data else{
                completion(nil, NetworkError.NoData)
                return
            }
            
            let returnVal = determineType(url, data, objectList, object)
            
            completion(returnVal, nil)
            
        }.resume()
        
    }
    
    private class func determineType(_ url:URL,_ data:Data,_ objectList:ObjectListType,_ object:ObjectType)->Any{
        do{
            let decoder = JSONDecoder()
            //let urlComponents = url.pathComponents
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            guard objectList != .nothing else{
                switch object{
                case .film:
                    return try decoder.decode(Film.self, from: data)
                case .character:
                    return try decoder.decode(Person.self, from: data)
                case .planet:
                    return try decoder.decode(Planet.self, from: data)
                case .species:
                    return try decoder.decode(Specie.self, from: data)
                case .starship:
                    return try decoder.decode(Starship.self, from: data)
                default:
                    return try decoder.decode(Vehicle.self, from: data)
                }
            }
                
            switch objectList{
            case .root:
                return try decoder.decode(Root.self, from: data)
            case .films:
                return try decoder.decode(Films.self, from: data)
            case .characters:
                return try decoder.decode(People.self, from: data)
            case .planets:
                return try decoder.decode(Planets.self, from: data)
            case .species:
                return try decoder.decode(Species.self, from: data)
            case .starships:
                return try decoder.decode(Starships.self, from: data)
            default:
                return try decoder.decode(Vehicles.self, from: data)
            }
            
        }catch let error{
            print("JSON decoding didn't work \(error.localizedDescription)")
        }
        fatalError("Cannot parse JSON files")
    }
    
    
    
    
}
