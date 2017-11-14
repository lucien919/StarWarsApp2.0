//
//  Starship.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

struct Starships:Codable{
    var count:Int
    var next:URL?
    var previous:URL?
    var results:[Starship]
}

struct Starship:Codable{
    var name:String
    var model:String
    var manufacturer:String
    var cost_in_credits:String
    var length:String
    var max_atmosphering_speed:String
    var crew:String
    var passengers:String
    var cargo_capacity:String
    var consumables:String
    var hyperdrive_rating:String
    var MGLT:String
    var starship_class:String
    var pilots:[URL]?         //[String]
    var films:[URL]?            //[String]
    var created:String
    var edited:String
    var url:URL
    
    func getPilotNames(completion: @escaping (String)->()){
        pilots?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.character){
                (object, error) in
                guard error == nil else{return}
                guard let pilot = object as? Person else{return}
                
                completion(pilot.name)
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
