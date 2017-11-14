//
//  Character.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

struct People:Codable{
    var count:Int
    var next:URL?
    var previous:URL?
    var results:[Person]
}

struct Person:Codable{
    var name:String
    var height:String
    var mass:String
    var hair_color:String
    var skin_color:String
    var eye_color:String
    var birth_year:String
    var gender:String
    var homeworld:URL
    var films:[URL]?                //[String]
    var species:[URL]?            //[String]
    var vehicles:[URL]?          //[String]
    var starships:[URL]?        //[String]
    var created:String
    var edited:String
    var url:URL
    
    func getFilmTitles(completion: @escaping (String)->()){
        films?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.film){
                (object, error) in
                guard error==nil else{return}
                guard let film = object as? Film else{return}
                
                completion(film.title)
            }
        }
    }
    
    func getSpeciesNames(completion: @escaping (String)->()){
        species?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.species){
                (object, error) in
                guard error==nil else{return}
                guard let species = object as? Specie else{return}
                
                completion(species.name)
            }
        }
    }
    
    func getVehicleNames(completion: @escaping (String)->()){
        vehicles?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.vehicle){
                (object, error) in
                guard error==nil else{return}
                guard let vehicle = object as? Vehicle else{return}
                
                completion(vehicle.name)
            }
        }
    }
    
    func getStarshipNames(completion: @escaping (String)->()){
        starships?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.starship){
                (object, error) in
                guard error==nil else{return}
                guard let starship = object as? Starship else{return}
                
                completion(starship.name)
            }
        }
    }
    
    func getHomeworldName(completion: @escaping (String)->()){
        Networking.getAPI(homeworld, ObjectListType.nothing, ObjectType.planet){
            (object, error) in
            guard error == nil else{return}
            guard let planet = object as? Planet else{return}
            
            completion(planet.name)
        }
    }
}
