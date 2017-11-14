//
//  Planet.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

struct Planets:Codable{
    var count:Int
    var next:URL?
    var previous:URL?
    var results:[Planet]
}

struct Planet:Codable{
    var name:String
    var rotation_period:String
    var orbital_period:String
    var diameter:String
    var climate:String
    var gravity:String
    var terrain:String
    var surface_water:String
    var population:String
    var residents:[URL]?      //[String]
    var films:[URL]?            //[String]
    var created:String
    var edited:String
    var url:URL
    
    func getResidentNames(completion: @escaping (String)->()){
        residents?.forEach{
            Networking.getAPI($0, ObjectListType.nothing, ObjectType.character){
                (object, error) in
                guard error==nil else{return}
                guard let resident = object as? Person else{return}
                
                completion(resident.name)
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
