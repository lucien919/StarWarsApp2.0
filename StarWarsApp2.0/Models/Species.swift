//
//  Species.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

struct Species:Codable{
    var count:Int
    var next:URL?
    var previous:URL?
    var results:[Specie]
}

struct Specie:Codable{
    var name:String
    var classification:String
    var designation:String
    var average_height:String
    var skin_colors:String
    var hair_colors:String
    var eye_colors:String
    var average_lifespan:String
    var homeworld:URL?
    var language:String
    var people:[URL]?         //[String]
    var films:[URL]?            //[String]
    var created:String
    var edited:String
    var url:URL
    
    func getHomeworldName(completion: @escaping (String)->()){
        guard let homeworld = homeworld else{return}
        Networking.getAPI(homeworld, ObjectListType.nothing, ObjectType.planet){
            (object, error) in
            guard error==nil else{return}
            guard let planet = object as? Planet else{return}
            
            completion(planet.name)
        }
    }
    
    func getCharacterNames(completion: @escaping (String)->()){
        people?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.character){
                (object, error) in
                guard error==nil else{return}
                guard let character = object as? Person else{return}
                
                completion(character.name)
            }
        }
    }
    
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
}
