//
//  Film.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

struct Films:Codable{
    var count:Int
    var next:URL?
    var previous:URL?
    var results:[Film]
}

struct Film:Codable{
    var title:String
    var episode_id:Int
    var opening_crawl:String
    var director:String
    var producer:String
    var release_date:Date
    var characters:[URL]?         //[String]
    var planets:[URL]?            //[String]
    var starships:[URL]?        //[String]
    var vehicles:[URL]?          //[String]
    var species:[URL]?            //[String]
    var created:String
    var edited:String
    var url:URL
    
    
    func getCharacterNames(completion: @escaping (String)->()){
        characters?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.character){
                (object, error) in
                guard error == nil else{return}
                guard let char = object as? Person else{return}
    
                completion(char.name)
            }
        }
    }
    
    func getPlanetNames(completion: @escaping (String)->()){
        planets?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.planet){
                (object, error) in
                guard error == nil else{return}
                guard let planet = object as? Planet else{return}
                
                completion(planet.name)
            }
        }
        
    }
    
    func getStarshipNames(completion: @escaping (String)->()){
        starships?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.starship){
                (object, error) in
                guard error == nil else{return}
                guard let starship = object as? Starship else{return}
                
                completion(starship.name)
            }
        }
    }
    
    func getVehicleNames(completion: @escaping (String)->()){
        vehicles?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.vehicle){
                (object, error) in
                guard error == nil else{return}
                guard let vehicle = object as? Vehicle else{return}
            
                completion(vehicle.name)
            }
        }
    }
    
    func getSpeciesNames(completion: @escaping (String)->()){
        species?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.species){
                (object, error) in
                guard error == nil else{return}
                guard let species = object as? Specie else{return}
                
                completion(species.name)
            }
        }
    }
}
