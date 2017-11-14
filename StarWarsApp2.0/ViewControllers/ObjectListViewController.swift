//
//  ObjectListViewController.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ObjectListViewController:UIViewController{
    @IBOutlet weak var objectListTable:UITableView!
    
    var operationQueue:OperationQueue = OperationQueue()
    
    var objectList:Any?
    var objectListType:ObjectListType?
    
    var films:[Film]?
    var filmCharacters:[[Person]]? = [[]]
    var filmPlanets:[[Planet]]? = [[]]
    var filmSpecies:[[Specie]]? = [[]]
    var filmStarships:[[Starship]]? = [[]]
    var filmVehicles:[[Vehicle]]? = [[]]
    
    var characters:[Person]?
    var characterHomeworld:[Planet]? = []
    var characterFilms:[[Film]]? = [[]]
    var characterSpecies:[[Specie]]? = [[]]
    var characterStarships:[[Starship]]? = [[]]
    var characterVehicles:[[Vehicle]]? = [[]]
    
    var planets:[Planet]?
    var planetResidents:[[Person]]? = [[]]
    var planetFilms:[[Film]]? = [[]]
    
    var species:[Specie]?
    var speciesHomeworld:[Planet]? = []
    var speciesCharacters:[[Person]]? = [[]]
    var speciesFilms:[[Film]]? = [[]]
    
    var starships:[Starship]?
    var starshipPilots:[[Person]]? = [[]]
    var starshipFilms:[[Film]]? = [[]]
    
    var vehicles:[Vehicle]?
    var vehiclePilots:[[Person]]? = [[]]
    var vehicleFilms:[[Film]]? = [[]]
    
    var selectedObject:Any?
    var selectedObjectType:ObjectType?
    var selectedObjectSubVals1:Any?
    var selectedObjectSubVals2:Any?
    var selectedObjectSubVals3:Any?
    var selectedObjectSubVals4:Any?
    var selectedObjectSubVals5:Any?
    var selectedObjectSubValHomeworld:Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objectListTable.delegate = self
        self.objectListTable.dataSource = self
        
        setType()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Background"))
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Background"))
        self.objectListTable.backgroundView = imageView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let n = segue.destination as? UINavigationController else{return}
        guard let v = n.viewControllers.first as? ObjectViewController else{return}
        
        v.object = self.selectedObject
        v.objectType = self.selectedObjectType
        v.objectSubVals1 = self.selectedObjectSubVals1
        v.objectSubVals2 = self.selectedObjectSubVals2
        v.objectSubVals3 = self.selectedObjectSubVals3
        v.objectSubVals4 = self.selectedObjectSubVals4
        v.objectSubVals5 = self.selectedObjectSubVals5
        v.objectSubValHomeworld = self.selectedObjectSubValHomeworld
    }
    
}

typealias ObjectTableViewFunctions = ObjectListViewController
extension ObjectTableViewFunctions: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaultVal = 0
        guard let type = self.objectListType else{return defaultVal}
        
        switch type {
        case .films :
            guard let count = films?.count else{return defaultVal}
            return count
        case .characters:
            guard let count = characters?.count else{return defaultVal}
            return count
        case .planets:
            guard let count = planets?.count else{return defaultVal}
            return count
        case .species:
            guard let count = species?.count else{return defaultVal}
            return count
        case .starships:
            guard let count = starships?.count else{return defaultVal}
            return count
        default:
            guard let count = vehicles?.count else{return defaultVal}
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let objectListCell = tableView.dequeueReusableCell(withIdentifier: "ObjectListCell") as? ObjectListCell else{fatalError("No cells")}
        
        objectListCell.cellImage?.image = #imageLiteral(resourceName: "Default")
        
        guard let type = self.objectListType else{return objectListCell}
        
        switch type {
        case .films :
            guard let title = films?[indexPath.row].title else{return objectListCell}
            guard let episodeNum = films?[indexPath.row].episode_id else{return objectListCell}
            objectListCell.label?.text = "Episode \(episodeNum): "+title
            objectListCell.cellImage.imageFrom(url: Networking.imageURLBase+title.removingWhitespaces()+".png", queue: operationQueue)
        case .characters:
            guard let val = characters?[indexPath.row].name else{return objectListCell}
            objectListCell.label?.text = val
            objectListCell.cellImage.imageFrom(url: Networking.imageURLBase+val.removingWhitespaces()+".png", queue: operationQueue)
        case .planets:
            guard let val = planets?[indexPath.row].name else{return objectListCell}
            objectListCell.label?.text = val
            objectListCell.cellImage.imageFrom(url: Networking.imageURLBase+val.removingWhitespaces()+".png", queue: operationQueue)
        case .species:
            guard let val = species?[indexPath.row].name else{return objectListCell}
            objectListCell.label?.text = val
            objectListCell.cellImage.imageFrom(url: Networking.imageURLBase+val.removingWhitespaces()+".png", queue: operationQueue)
        case .starships:
            guard let val = starships?[indexPath.row].name else{return objectListCell}
            objectListCell.label?.text = val
            objectListCell.cellImage.imageFrom(url: Networking.imageURLBase+val.removingWhitespaces()+".png", queue: operationQueue)
        default:
            guard let val = vehicles?[indexPath.row].name else{return objectListCell}
            objectListCell.label?.text = val
            objectListCell.cellImage.imageFrom(url: Networking.imageURLBase+val.removingWhitespaces()+".png", queue: operationQueue)
        }
        
        objectListCell.label?.textColor = UIColor.red
        return objectListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objectListTable.deselectRow(at: indexPath, animated: true)
        
        guard let type = self.objectListType else{return}
        
        switch type {
        case .films:
            selectedObject = films?[indexPath.row]
            selectedObjectType = ObjectType.film
            selectedObjectSubVals1 = filmCharacters?[indexPath.row]
            selectedObjectSubVals2 = filmPlanets?[indexPath.row]
            selectedObjectSubVals3 = filmSpecies?[indexPath.row]
            selectedObjectSubVals4 = filmStarships?[indexPath.row]
            selectedObjectSubVals5 = filmVehicles?[indexPath.row]
            selectedObjectSubValHomeworld = nil
        case .characters:
            selectedObject = characters?[indexPath.row]
            selectedObjectType = ObjectType.character
            selectedObjectSubVals1 = characterFilms?[indexPath.row]
            selectedObjectSubVals2 = characterSpecies?[indexPath.row]
            selectedObjectSubVals3 = characterStarships?[indexPath.row]
            selectedObjectSubVals4 = characterVehicles?[indexPath.row]
            selectedObjectSubVals5 = nil
            selectedObjectSubValHomeworld = characterHomeworld?[indexPath.row]
        case .planets:
            selectedObject = planets?[indexPath.row]
            selectedObjectType = ObjectType.planet
            selectedObjectSubVals1 = planetResidents?[indexPath.row]
            selectedObjectSubVals2 = planetFilms?[indexPath.row]
            selectedObjectSubVals3 = nil
            selectedObjectSubVals4 = nil
            selectedObjectSubVals5 = nil
            selectedObjectSubValHomeworld = nil
        case .species:
            selectedObject = species?[indexPath.row]
            selectedObjectType = ObjectType.species
            selectedObjectSubVals1 = speciesCharacters?[indexPath.row]
            selectedObjectSubVals2 = speciesFilms?[indexPath.row]
            selectedObjectSubVals3 = nil
            selectedObjectSubVals4 = nil
            selectedObjectSubVals5 = nil
            selectedObjectSubValHomeworld = speciesHomeworld?[indexPath.row]
        case .starships:
            selectedObject = starships?[indexPath.row]
            selectedObjectType = ObjectType.starship
            selectedObjectSubVals1 = starshipPilots?[indexPath.row]
            selectedObjectSubVals2 = starshipFilms?[indexPath.row]
            selectedObjectSubVals3 = nil
            selectedObjectSubVals4 = nil
            selectedObjectSubVals5 = nil
            selectedObjectSubValHomeworld = nil
        default:
            selectedObject = vehicles?[indexPath.row]
            selectedObjectType = ObjectType.vehicle
            selectedObjectSubVals1 = vehiclePilots?[indexPath.row]
            selectedObjectSubVals2 = vehicleFilms?[indexPath.row]
            selectedObjectSubVals3 = nil
            selectedObjectSubVals4 = nil
            selectedObjectSubVals5 = nil
            selectedObjectSubValHomeworld = nil
        }
        
        self.performSegue(withIdentifier: "ObjectListToObjectSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
}

typealias OtherObjectListFunctions = ObjectListViewController
extension OtherObjectListFunctions{
    
    func setType(){
        guard let type = self.objectListType else{return}
        
        switch type {
        case .films :
            guard let f = self.objectList as? [Film] else{return}
            self.films = f
            var counter = 0
            f.forEach{
                self.filmCharacters?.append([])
                $0.characters?.forEach{
                    callNetwork($0, ObjectListType.films, ObjectType.character, counter){val in}
                }
                self.filmPlanets?.append([])
                $0.planets?.forEach{
                    callNetwork($0, ObjectListType.films, ObjectType.planet, counter){val in}
                }
                self.filmSpecies?.append([])
                $0.species?.forEach{
                    callNetwork($0, ObjectListType.films, ObjectType.species, counter){val in}
                }
                self.filmStarships?.append([])
                $0.starships?.forEach{
                    callNetwork($0, ObjectListType.films, ObjectType.starship, counter){val in}
                }
                self.filmVehicles?.append([])
                $0.vehicles?.forEach{
                    callNetwork($0, ObjectListType.films, ObjectType.vehicle, counter){val in}
                }
                counter += 1
            }
        case .characters:
            guard let c = self.objectList as? [Person] else{return}
            self.characters = c
            var counter = 0
            c.forEach{
                callNetwork($0.homeworld, ObjectListType.characters, ObjectType.planet, counter){val in}
                self.characterFilms?.append([])
                $0.films?.forEach{
                    callNetwork($0, ObjectListType.characters, ObjectType.film, counter){val in}
                }
                self.characterSpecies?.append([])
                $0.species?.forEach{
                    callNetwork($0, ObjectListType.characters, ObjectType.species, counter){val in}
                }
                self.characterStarships?.append([])
                $0.starships?.forEach{
                    callNetwork($0, ObjectListType.characters, ObjectType.starship, counter){val in}
                }
                self.characterVehicles?.append([])
                $0.vehicles?.forEach{
                    callNetwork($0, ObjectListType.characters, ObjectType.vehicle, counter){val in}
                }
                counter += 1
            }
        case .planets:
            guard let p = self.objectList as? [Planet] else{return}
            self.planets = p
            var counter = 0
            p.forEach{
                self.planetFilms?.append([])
                $0.films?.forEach{
                    callNetwork($0, ObjectListType.planets, ObjectType.film, counter){val in}
                }
                self.planetResidents?.append([])
                $0.residents?.forEach{
                    callNetwork($0, ObjectListType.planets, ObjectType.character, counter){val in}
                }
                counter += 1
            }
        case .species:
            guard let sp = self.objectList as? [Specie] else{return}
            self.species = sp
            var counter = 0
            sp.forEach{
                self.speciesFilms?.append([])
                $0.films?.forEach{
                    callNetwork($0, ObjectListType.species, ObjectType.film, counter){val in}
                }
                self.speciesCharacters?.append([])
                $0.people?.forEach{
                    callNetwork($0, ObjectListType.species, ObjectType.character, counter){val in}
                }
                guard let hw = $0.homeworld else{return}
                
                callNetwork(hw, ObjectListType.species, ObjectType.planet, counter){val in}
                counter += 1
            }
        case .starships:
            guard let st = self.objectList as? [Starship] else{return}
            self.starships = st
            var counter = 0
            st.forEach{
                self.starshipFilms?.append([])
                $0.films?.forEach{
                    callNetwork($0, ObjectListType.starships, ObjectType.film, counter){val in}
                }
                self.starshipPilots?.append([])
                $0.pilots?.forEach{
                    callNetwork($0, ObjectListType.starships, ObjectType.character, counter){val in}
                }
                counter += 1
            }
        default:
            guard let v = self.objectList as? [Vehicle] else{return}
            self.vehicles = v
            var counter = 0
            v.forEach{
                self.vehicleFilms?.append([])
                $0.films?.forEach{
                    callNetwork($0, ObjectListType.vehicles, ObjectType.film, counter){val in}
                }
                self.vehiclePilots?.append([])
                $0.pilots?.forEach{
                    callNetwork($0, ObjectListType.vehicles, ObjectType.character, counter){val in}
                }
                counter += 1
            }
        }
    }
    
    func callNetwork(_ url:URL,_ typeList:ObjectListType,_ type:ObjectType,_ column:Int ,completion: @escaping(Any)->()){
        Networking.getAPI(url, ObjectListType.nothing, type){
            (object, error) in
            guard error==nil else{return}
            
            switch typeList{
            case .films:
                switch type{
                case .character:
                    guard let val = object as? Person else{return}
                    self.filmCharacters?[column].append(val)
                    completion(val)
                case .planet:
                    guard let val = object as? Planet else{return}
                    self.filmPlanets?[column].append(val)
                    completion(val)
                case .species:
                    guard let val = object as? Specie else{return}
                    self.filmSpecies?[column].append(val)
                    completion(val)
                case .starship:
                    guard let val = object as? Starship else{return}
                    self.filmStarships?[column].append(val)
                    completion(val)
                default:
                    guard let val = object as? Vehicle else{return}
                    self.filmVehicles?[column].append(val)
                    completion(val)
                }
            case .characters:
                switch type{
                case .planet:
                    guard let val = object as? Planet else{return}
                    self.characterHomeworld?.append(val)
                    completion(val)
                case .film:
                    guard let val = object as? Film else{return}
                    self.characterFilms?[column].append(val)
                    completion(val)
                case .species:
                    guard let val = object as? Specie else{return}
                    self.characterSpecies?[column].append(val)
                    completion(val)
                case .starship:
                    guard let val = object as? Starship else{return}
                    self.characterStarships?[column].append(val)
                    completion(val)
                default:
                    guard let val = object as? Vehicle else{return}
                    self.characterVehicles?[column].append(val)
                    completion(val)
                }
            case .planets:
                switch type{
                case .film:
                    guard let val = object as? Film else{return}
                    self.planetFilms?[column].append(val)
                    completion(val)
                default:
                    guard let val = object as? Person else{return}
                    self.planetResidents?[column].append(val)
                    completion(val)
                }
            case .species:
                switch type{
                case .planet:
                    guard let val = object as? Planet else{return}
                    self.speciesHomeworld?.append(val)
                    completion(val)
                case .film:
                    guard let val = object as? Film else{return}
                    self.speciesFilms?[column].append(val)
                    completion(val)
                default:
                    guard let val = object as? Person else{return}
                    self.speciesCharacters?[column].append(val)
                    completion(val)
                }
            case .starships:
                switch type{
                case .film:
                    guard let val = object as? Film else{return}
                    self.starshipFilms?[column].append(val)
                    completion(val)
                default:
                    guard let val = object as? Person else{return}
                    self.starshipPilots?[column].append(val)
                    completion(val)
                }
            default:
                switch type{
                case .film:
                    guard let val = object as? Film else{return}
                    self.vehicleFilms?[column].append(val)
                    completion(val)
                default:
                    guard let val = object as? Person else{return}
                    self.vehiclePilots?[column].append(val)
                    completion(val)
                }
                
            }
        }
        
        
        
    }
    
    
}
