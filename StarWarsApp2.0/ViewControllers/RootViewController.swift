//
//  ViewController.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var rootTable:UITableView!
    
    var root:Root?
    var film:[Film]? = []
    var character:[Person]? = []
    var planet:[Planet]? = []
    var species:[Specie]? = []
    var starship:[Starship]? = []
    var vehicle:[Vehicle]? = []
    
    var selectedObjectList:Any?
    var selectedObjectListType:ObjectListType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootTable.delegate = self
        self.rootTable.dataSource = self
        
        guard let url = URL(string: Networking.rootURL) else{return}
        
        initialSetup(url)
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Background"))
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Background"))
        self.rootTable.backgroundView = imageView
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let v = segue.destination as? ObjectListViewController else{return}
        
        v.objectList = self.selectedObjectList
        v.objectListType = self.selectedObjectListType
    }
    
    
}

typealias TableViewFunctions = RootViewController
extension TableViewFunctions:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rootCell = tableView.dequeueReusableCell(withIdentifier: "RootCell") as? RootCell else{fatalError("There is not cell")}
        
        switch indexPath.row {
        case 0:
            rootCell.label?.text = "Films"
        case 1:
            rootCell.label?.text = "Characters"
        case 2:
            rootCell.label?.text = "Planets"
        case 3:
            rootCell.label?.text = "Species"
        case 4:
            rootCell.label?.text = "Starships"
        default:
            rootCell.label?.text = "Vehicles"
        }
        
        rootCell.label?.textColor = UIColor.red
        return rootCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rootTable.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            selectedObjectList = film
            selectedObjectListType = ObjectListType.films
        case 1:
            selectedObjectList = character
            selectedObjectListType = ObjectListType.characters
        case 2:
            selectedObjectList = planet
            selectedObjectListType = ObjectListType.planets
        case 3:
            selectedObjectList = species
            selectedObjectListType = ObjectListType.species
        case 4:
            selectedObjectList = starship
            selectedObjectListType = ObjectListType.starships
        default:
            selectedObjectList = vehicle
            selectedObjectListType = ObjectListType.vehicles
        }
        
        self.performSegue(withIdentifier: "RootToObjectListSegue", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

typealias OtherRootFunctions = RootViewController
extension OtherRootFunctions{
    
    func initialSetup(_ url:URL){
        callNetwork(url, ObjectListType.root){
            val in
            guard let root = val as? Root else{return}
            self.root = root
            
            self.callNetwork(root.films, ObjectListType.films){
                val in
                self.film = self.film?.sorted{$0.episode_id < $1.episode_id}
            }
            
            self.callNetwork(root.people, ObjectListType.characters){
                val in
                self.character = self.character?.sorted{$0.name < $1.name}
            }
            
            self.callNetwork(root.planets, ObjectListType.planets){
                val in
                self.planet = self.planet?.sorted{$0.name < $1.name}
            }
            
            self.callNetwork(root.species, ObjectListType.species){
                val in
                self.species = self.species?.sorted{$0.name < $1.name}
            }
            
            self.callNetwork(root.starships, ObjectListType.starships){
                val in
                self.starship = self.starship?.sorted{$0.name < $1.name}
            }
            
            self.callNetwork(root.vehicles, ObjectListType.vehicles){
                val in
                self.vehicle = self.vehicle?.sorted{$0.name < $1.name}
            }
        }
    }
    
    func callNetwork(_ url:URL,_ type:ObjectListType, completion: @escaping(Any)->()){
        Networking.getAPI(url, type, ObjectType.nothing){
            (object, error) in
            guard error==nil else{return}
            
            switch type{
            case .root:
                guard let val = object as? Root else{return}
                completion(val)
            case .films:
                guard let val = object as? Films else{return}
                self.film?.append(contentsOf: val.results)
                if(val.next != nil){self.callNetwork(val.next!, type){
                    value in
                    completion(value)
                    }
                }
                completion(val)
            case .characters:
                guard let val = object as? People else{return}
                self.character?.append(contentsOf: val.results)
                if(val.next != nil){self.callNetwork(val.next!, type){
                    value in
                    completion(value)
                    }
                }
                completion(val)
            case .planets:
                guard let val = object as? Planets else{return}
                self.planet?.append(contentsOf: val.results)
                if(val.next != nil){self.callNetwork(val.next!, type){
                    value in
                    completion(value)
                    }
                }
                completion(val)
            case .species:
                guard let val = object as? Species else{return}
                self.species?.append(contentsOf: val.results)
                if(val.next != nil){self.callNetwork(val.next!, type){
                    value in
                    completion(value)
                    }
                }
                completion(val)
            case .starships:
                guard let val = object as? Starships else{return}
                self.starship?.append(contentsOf: val.results)
                if(val.next != nil){self.callNetwork(val.next!, type){
                    value in
                    completion(value)
                    }
                }
                completion(val)
            default:
                guard let val = object as? Vehicles else{return}
                self.vehicle?.append(contentsOf: val.results)
                if(val.next != nil){self.callNetwork(val.next!, type){
                    value in
                    completion(value)
                    }
                }
                completion(val)
            }
        }
    }
    
    
}

