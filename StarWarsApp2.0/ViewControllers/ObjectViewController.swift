//
//  ObjectViewController.swift
//  StarWarsApp2.0
//
//  Created by Mac on 11/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ObjectViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var objectCollectionView:UICollectionView!
    @IBOutlet weak var backButton:UIBarButtonItem!
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var objectImage:UIImageView!
    @IBOutlet weak var firstLabel:UILabel!
    @IBOutlet weak var secondLabel:UILabel!
    @IBOutlet weak var thirdLabel:UILabel!
    @IBOutlet weak var fourthLabel:UILabel!
    @IBOutlet weak var fifthLabel:UILabel!
    @IBOutlet weak var sixthLabel:UILabel!
    @IBOutlet weak var seventhLabel:UILabel!
    @IBOutlet weak var eighthLabel:UILabel!
    @IBOutlet weak var ninethLabel:UILabel!
    @IBOutlet weak var tenthLabel:UILabel!
    @IBOutlet weak var eleventhLabel:UILabel!
    @IBOutlet weak var twelvthLabel:UILabel!
    @IBOutlet weak var thirteenthLabel:UILabel!
    
    var operationQueue = OperationQueue()
    
    //MARK: Values Read In
    var object:Any?
    var objectType:ObjectType?
    var objectSubVals1:Any?
    var objectSubVals2:Any?
    var objectSubVals3:Any?
    var objectSubVals4:Any?
    var objectSubVals5:Any?
    var objectSubValHomeworld:Any?
    //MARK: Film
    var film:Film?
    
    var cFilmCharacters:[Person]?
    var cFilmPlanets:[Planet]?
    var cFilmSpecies:[Specie]?
    var cFilmStarships:[Starship]?
    var cFilmVehicles:[Vehicle]?
    
    //MARK: Character
    var character:Person?
    
    var cCharacterHomeworld:Planet?
    var cCharacterFilms:[Film]?
    var cCharacterSpecies:[Specie]?
    var cCharacterStarships:[Starship]?
    var cCharacterVehicles:[Vehicle]?
    
    //MARK: Planet
    var planet:Planet?
   
    var cPlanetResidents:[Person]?
    var cPlanetFilms:[Film]?
    
    //MARK: Specie
    var species:Specie?
   
    var cSpeciesHomeworld:Planet?
    var cSpeciesCharacters:[Person]?
    var cSpeciesFilms:[Film]?
    
    //MARK: Starship
    var starship:Starship?
    
    var cStarshipPilots:[Person]?
    var cStarshipFilms:[Film]?
    
    //MARK: Vehicle
    var vehicle:Vehicle?
    
    var cVehiclePilots:[Person]?
    var cVehicleFilms:[Film]?

    
    //MARK: NextVals
    
    var nFilms:[Film]? = []
    var nCharacter:[Person]? = []
    var nPlanets:[Planet]? = []
    var nSpecies:[Specie]? = []
    var nStarships:[Starship]? = []
    var nVehicles:[Vehicle]? = []
    
    //MARK: Selected
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
        
        self.objectCollectionView.delegate = self
        self.objectCollectionView.dataSource = self
        
        setType()
        insertData()
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Background"))
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Background"))
        self.objectCollectionView.backgroundView = imageView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let n = segue.destination as? UINavigationController else{return}
        guard let v = n.viewControllers.first as? ObjectViewController else{return}
    
        guard let type = self.selectedObjectType else{return}
        
        v.object = self.selectedObject
        v.objectType = type
        
        v.objectSubVals1 = self.selectedObjectSubVals1
        v.objectSubVals2 = self.selectedObjectSubVals2
        v.objectSubVals3 = self.selectedObjectSubVals3
        v.objectSubVals4 = self.selectedObjectSubVals4
        v.objectSubVals5 = self.selectedObjectSubVals5
        v.objectSubValHomeworld = self.selectedObjectSubValHomeworld
        
//        switch type {
//        case .film:
//            v.objectSubVals1 = self.nCharacter
//            v.objectSubVals2 = self.nPlanets
//            v.objectSubVals3 = self.nSpecies
//            v.objectSubVals4 = self.nStarships
//            v.objectSubVals5 = self.nVehicles
//            v.objectSubValHomeworld = nil
//        case .character:
//            v.objectSubVals1 = self.nFilms
//            v.objectSubVals2 = self.nSpecies
//            v.objectSubVals3 = self.nStarships
//            v.objectSubVals4 = self.nVehicles
//            v.objectSubVals5 = nil
//            v.objectSubValHomeworld = self.nPlanets?.first
//        case .planet:
//            v.objectSubVals1 = self.nCharacter
//            v.objectSubVals2 = self.nFilms
//            v.objectSubVals3 = nil
//            v.objectSubVals4 = nil
//            v.objectSubVals5 = nil
//            v.objectSubValHomeworld = nil
//        case .species:
//            v.objectSubVals1 = self.nCharacter
//            v.objectSubVals2 = self.nFilms
//            v.objectSubVals3 = nil
//            v.objectSubVals4 = nil
//            v.objectSubVals5 = nil
//            v.objectSubValHomeworld = self.nPlanets?.first
//        case .starship:
//            v.objectSubVals1 = self.nCharacter
//            v.objectSubVals2 = self.nFilms
//            v.objectSubVals3 = nil
//            v.objectSubVals4 = nil
//            v.objectSubVals5 = nil
//            v.objectSubValHomeworld = nil
//        default:
//            v.objectSubVals1 = self.nCharacter
//            v.objectSubVals2 = self.nFilms
//            v.objectSubVals3 = nil
//            v.objectSubVals4 = nil
//            v.objectSubVals5 = nil
//            v.objectSubValHomeworld = nil
//        }
        nFilms?.removeAll()
        nCharacter?.removeAll()
        nPlanets?.removeAll()
        nSpecies?.removeAll()
        nStarships?.removeAll()
        nVehicles?.removeAll()
    }
    
    
}

typealias ObjectCollectionViewFunctions = ObjectViewController
extension ObjectCollectionViewFunctions: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let type = self.objectType else{return 0}
        
        switch type {
        case .film:
            return 5
        case .character:
            return 5
        case .planet:
            return 2
        case .species:
            return 3
        case .starship:
            return 2
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let defaultVal = 0
        guard let type = self.objectType else{return defaultVal}
        
        switch type {
        case .film:
            guard let f = self.film else{return defaultVal}
            
            switch section{
            case 0:
                guard let count = f.characters?.count else{return defaultVal}
                return count
            case 1:
                guard let count = f.planets?.count else{return defaultVal}
                return count
            case 2:
                guard let count = f.species?.count else{return defaultVal}
                return count
            case 3:
                guard let count = f.starships?.count else{return defaultVal}
                return count
            default:
                guard let count = f.vehicles?.count else{return defaultVal}
                return count
            }
        case .character:
            guard let c = self.character else{return defaultVal}
            
            switch section{
            case 0:
                return 1
            case 1:
                guard let count = c.films?.count else{return defaultVal}
                return count
            case 2:
                guard let count = c.species?.count else{return defaultVal}
                return count
            case 3:
                guard let count = c.starships?.count else{return defaultVal}
                return count
            default:
                guard let count = c.vehicles?.count else{return defaultVal}
                return count
            }
        case .planet:
            guard let p = self.planet else{return defaultVal}
            
            switch section{
            case 0:
                guard let count = p.residents?.count else{return defaultVal}
                return count
            default:
                guard let count = p.films?.count else{return defaultVal}
                return count
            }
        case .species:
            guard let sp = self.species else{return defaultVal}
            
            switch section{
            case 0:
                guard sp.homeworld != nil else{return defaultVal}
                return 1
            case 1:
                guard let count = sp.people?.count else{return defaultVal}
                return count
            default:
                guard let count = sp.films?.count else{return defaultVal}
                return count
            }
        case .starship:
            guard let st = self.starship else{return defaultVal}
            
            switch section{
            case 0:
                guard let count = st.pilots?.count else{return defaultVal}
                return count
            default:
                guard let count = st.films?.count else{return defaultVal}
                return count
            }
        default:
            guard let v = self.vehicle else{return defaultVal}
            
            switch section{
            case 0:
                guard let count = v.pilots?.count else{return defaultVal}
                return count
            default:
                guard let count = v.films?.count else{return defaultVal}
                return count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ObjectCell", for: indexPath) as? CollectionCell else{fatalError("Cell not available")}
        
        cell.imageView.image = #imageLiteral(resourceName: "Default")
        
        guard let type = self.objectType else{return cell}

        switch type {
        case .film:
            switch indexPath.section{
            case 0:
                guard let count = self.cFilmCharacters?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let c = self.cFilmCharacters?[indexPath.row] else{return cell}
                cell.imageLabel.text = c.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+c.name.removingWhitespaces()+".png", queue: operationQueue)
            case 1:
                guard let count = self.cFilmPlanets?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let p = self.cFilmPlanets?[indexPath.row] else{return cell}
                cell.imageLabel.text = p.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+p.name.removingWhitespaces()+".png", queue: operationQueue)
            case 2:
                guard let count = self.cFilmSpecies?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let sp = self.cFilmSpecies?[indexPath.row] else{return cell}
                cell.imageLabel.text = sp.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+sp.name.removingWhitespaces()+".png", queue: operationQueue)
            case 3:
                guard let count = self.cFilmStarships?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let st = self.cFilmStarships?[indexPath.row] else{return cell}
                cell.imageLabel.text = st.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+st.name.removingWhitespaces()+".png", queue: operationQueue)
            default:
                guard let count = self.cFilmVehicles?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let v = self.cFilmVehicles?[indexPath.row] else{return cell}
                cell.imageLabel.text = v.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+v.name.removingWhitespaces()+".png", queue: operationQueue)
            }
        case .character:
            switch indexPath.section{
            case 0:
                guard let hw = self.cCharacterHomeworld else{return cell}
                cell.imageLabel.text = hw.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+hw.name.removingWhitespaces()+".png", queue: operationQueue)
            case 1:
                guard let count = self.cCharacterFilms?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let f = self.cCharacterFilms?[indexPath.row] else{return cell}
                cell.imageLabel.text = f.title
                cell.imageView.imageFrom(url: Networking.imageURLBase+f.title.removingWhitespaces()+".png", queue: operationQueue)
            case 2:
                guard let count = self.cCharacterSpecies?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let sp = self.cCharacterSpecies?[indexPath.row] else{return cell}
                cell.imageLabel.text = sp.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+sp.name.removingWhitespaces()+".png", queue: operationQueue)
            case 3:
                guard let count = self.cCharacterStarships?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let st = self.cCharacterStarships?[indexPath.row] else{return cell}
                cell.imageLabel.text = st.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+st.name.removingWhitespaces()+".png", queue: operationQueue)
            default:
                guard let count = self.cCharacterVehicles?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let v = self.cCharacterVehicles?[indexPath.row] else{return cell}
                cell.imageLabel.text = v.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+v.name.removingWhitespaces()+".png", queue: operationQueue)
            }
        case .planet:
            switch indexPath.section{
            case 0:
                guard let count = self.cPlanetResidents?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let r = self.cPlanetResidents?[indexPath.row] else{return cell}
                cell.imageLabel.text = r.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+r.name.removingWhitespaces()+".png", queue: operationQueue)
            default:
                guard let count = self.cPlanetFilms?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let f = self.cPlanetFilms?[indexPath.row] else{return cell}
                cell.imageLabel.text = f.title
                cell.imageView.imageFrom(url: Networking.imageURLBase+f.title.removingWhitespaces()+".png", queue: operationQueue)
            }
        case .species:
            switch indexPath.section{
            case 0:
                guard let hw = self.cSpeciesHomeworld else{return cell}
                cell.imageLabel.text = hw.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+hw.name.removingWhitespaces()+".png", queue: operationQueue)
            case 1:
                guard let count = self.cSpeciesCharacters?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let c = self.cSpeciesCharacters?[indexPath.row] else{return cell}
                cell.imageLabel.text = c.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+c.name.removingWhitespaces()+".png", queue: operationQueue)
            default:
                guard let count = self.cSpeciesFilms?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let f = self.cSpeciesFilms?[indexPath.row] else{return cell}
                cell.imageLabel.text = f.title
                cell.imageView.imageFrom(url: Networking.imageURLBase+f.title.removingWhitespaces()+".png", queue: operationQueue)
            }
        case .starship:
            switch indexPath.section{
            case 0:
                guard let count = self.cStarshipPilots?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let p = self.cStarshipPilots?[indexPath.row] else{return cell}
                cell.imageLabel.text = p.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+p.name.removingWhitespaces()+".png", queue: operationQueue)
            default:
                guard let count = self.cStarshipFilms?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let f = self.cStarshipFilms?[indexPath.row] else{return cell}
                cell.imageLabel.text = f.title
                cell.imageView.imageFrom(url: Networking.imageURLBase+f.title.removingWhitespaces()+".png", queue: operationQueue)
            }
        default:
            switch indexPath.section{
            case 0:
                guard let count = self.cVehiclePilots?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let p = self.cVehiclePilots?[indexPath.row] else{return cell}
                cell.imageLabel.text = p.name
                cell.imageView.imageFrom(url: Networking.imageURLBase+p.name.removingWhitespaces()+".png", queue: operationQueue)
            default:
                guard let count = self.cVehicleFilms?.count else{return cell}
                guard count > indexPath.row else{return cell}
                guard let f = self.cVehicleFilms?[indexPath.row] else{return cell}
                cell.imageLabel.text = f.title
                cell.imageView.imageFrom(url: Networking.imageURLBase+f.title.removingWhitespaces()+".png", queue: operationQueue)
            }
        }
        
        cell.imageLabel?.textColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeaderView else{fatalError("Reusable view not found")}
        
        guard let type = self.objectType else{return sectionHeader}
        
        switch type {
        case .film:
            switch indexPath.section{
            case 0:
                sectionHeader.categorLabel.text = "Characters"
            case 1:
                sectionHeader.categorLabel.text = "Planets"
            case 2:
                sectionHeader.categorLabel.text = "Species"
            case 3:
                sectionHeader.categorLabel.text = "Starships"
            default:
                sectionHeader.categorLabel.text = "Vehicles"
            }
        case .character:
            switch indexPath.section{
            case 0:
                sectionHeader.categorLabel.text = "Homeworld"
            case 1:
                sectionHeader.categorLabel.text = "Films"
            case 2:
                sectionHeader.categorLabel.text = "Species"
            case 3:
                sectionHeader.categorLabel.text = "Starships"
            default:
                sectionHeader.categorLabel.text = "Vehicles"
            }
        case .planet:
            switch indexPath.section{
            case 0:
                sectionHeader.categorLabel.text = "Residents"
            default:
                sectionHeader.categorLabel.text = "Films"
            }
        case .species:
            switch indexPath.section{
            case 0:
                sectionHeader.categorLabel.text = "Homeworld"
            case 1:
                sectionHeader.categorLabel.text = "People"
            default:
                sectionHeader.categorLabel.text = "Films"
            }
        case .starship:
            switch indexPath.section{
            case 0:
                sectionHeader.categorLabel.text = "Pilots"
            default:
                sectionHeader.categorLabel.text = "Films"
            }
        default:
            switch indexPath.section{
            case 0:
                sectionHeader.categorLabel.text = "Pilots"
            default:
                sectionHeader.categorLabel.text = "Films"
            }
        }
        sectionHeader.categorLabel.textColor = UIColor.red
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let type = self.objectType else{return}
        
        switch type {
        case .film:
            switch indexPath.section{
            case 0:
                guard let count = self.cFilmCharacters?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cFilmCharacters?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.character
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals1 = self.nFilms
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals2 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals3 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals4 = self.nVehicles
                    }
                }
                callNetwork(val.homeworld, ObjectType.planet){
                    value in
                    self.selectedObjectSubValHomeworld = self.nPlanets?.first
                }
            case 1:
                guard let count = self.cFilmPlanets?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cFilmPlanets?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.planet
                val.residents?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
            case 2:
                guard let count = self.cFilmSpecies?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cFilmSpecies?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.species
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
                val.people?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                guard let hw = val.homeworld else{return}
                callNetwork(hw, ObjectType.planet){
                    value in
                    self.selectedObjectSubValHomeworld = self.nPlanets?.first
                }
            case 3:
                guard let count = self.cFilmStarships?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cFilmStarships?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.starship
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
                val.pilots?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
            default:
                guard let count = self.cFilmVehicles?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cFilmVehicles?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.vehicle
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
                val.pilots?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
            }
        case .character:
            switch indexPath.section{
            case 0:
                guard let val = cCharacterHomeworld else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.planet
                val.residents?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
            case 1:
                guard let count = self.cCharacterFilms?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cCharacterFilms?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.film
                val.characters?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.planets?.forEach{
                    callNetwork($0, ObjectType.planet){
                        value in
                        self.selectedObjectSubVals2 = self.nPlanets
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals3 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals4 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals5 = self.nVehicles
                    }
                }
            case 2:
                guard let count = self.cCharacterSpecies?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cCharacterSpecies?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.species
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
                val.people?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                guard let hw = val.homeworld else{return}
                callNetwork(hw, ObjectType.planet){
                    value in
                    self.selectedObjectSubValHomeworld = self.nPlanets?.first
                }
            case 3:
                guard let count = self.cCharacterStarships?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cCharacterStarships?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.starship
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
                val.pilots?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
            default:
                guard let count = self.cCharacterVehicles?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cCharacterVehicles?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.vehicle
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
                val.pilots?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
            }
        case .planet:
            switch indexPath.section{
            case 0:
                guard let count = self.cPlanetResidents?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cPlanetResidents?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.character
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals1 = self.nFilms
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals2 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals3 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals4 = self.nVehicles
                    }
                }
                callNetwork(val.homeworld, ObjectType.planet){
                    value in
                    self.selectedObjectSubValHomeworld = self.nPlanets?.first
                }
            default:
                guard let count = self.cPlanetFilms?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cPlanetFilms?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.film
                val.characters?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.planets?.forEach{
                    callNetwork($0, ObjectType.planet){
                        value in
                        self.selectedObjectSubVals2 = self.nPlanets
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals3 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals4 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals5 = self.nVehicles
                    }
                }
            }
        case .species:
            switch indexPath.section{
            case 0:
                guard let val = cSpeciesHomeworld else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.planet
                val.residents?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals2 = self.nFilms
                    }
                }
            case 1:
                guard let count = self.cSpeciesCharacters?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cSpeciesCharacters?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.character
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals1 = self.nFilms
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals2 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals3 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals4 = self.nVehicles
                    }
                }
                callNetwork(val.homeworld, ObjectType.planet){
                    value in
                    self.selectedObjectSubValHomeworld = self.nPlanets?.first
                }
            default:
                guard let count = self.cSpeciesFilms?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cSpeciesFilms?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.film
                val.characters?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.planets?.forEach{
                    callNetwork($0, ObjectType.planet){
                        value in
                        self.selectedObjectSubVals2 = self.nPlanets
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals3 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals4 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals5 = self.nVehicles
                    }
                }
            }
        case .starship:
            switch indexPath.section{
            case 0:
                guard let count = self.cStarshipPilots?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cStarshipPilots?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.character
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals1 = self.nFilms
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals2 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals3 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals4 = self.nVehicles
                    }
                }
                callNetwork(val.homeworld, ObjectType.planet){
                    value in
                    self.selectedObjectSubValHomeworld = self.nPlanets?.first
                }
            default:
                guard let count = self.cStarshipFilms?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cStarshipFilms?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.film
                val.characters?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.planets?.forEach{
                    callNetwork($0, ObjectType.planet){
                        value in
                        self.selectedObjectSubVals2 = self.nPlanets
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals3 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals4 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals5 = self.nVehicles
                    }
                }
            }
        default:
            switch indexPath.section{
            case 0:
                guard let count = self.cVehiclePilots?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cVehiclePilots?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.character
                val.films?.forEach{
                    callNetwork($0, ObjectType.film){
                        value in
                        self.selectedObjectSubVals1 = self.nFilms
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals2 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals3 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals4 = self.nVehicles
                    }
                }
                callNetwork(val.homeworld, ObjectType.planet){
                    value in
                    self.selectedObjectSubValHomeworld = self.nPlanets?.first
                }
            default:
                guard let count = self.cVehicleFilms?.count else{return}
                guard count > indexPath.row else{return}
                guard let val = cVehicleFilms?[indexPath.row] else{return}
                self.selectedObject = val
                self.selectedObjectType = ObjectType.film
                val.characters?.forEach{
                    callNetwork($0, ObjectType.character){
                        value in
                        self.selectedObjectSubVals1 = self.nCharacter
                    }
                }
                val.planets?.forEach{
                    callNetwork($0, ObjectType.planet){
                        value in
                        self.selectedObjectSubVals2 = self.nPlanets
                    }
                }
                val.species?.forEach{
                    callNetwork($0, ObjectType.species){
                        value in
                        self.selectedObjectSubVals3 = self.nSpecies
                    }
                }
                val.starships?.forEach{
                    callNetwork($0, ObjectType.starship){
                        value in
                        self.selectedObjectSubVals4 = self.nStarships
                    }
                }
                val.vehicles?.forEach{
                    callNetwork($0, ObjectType.vehicle){
                        value in
                        self.selectedObjectSubVals5 = self.nVehicles
                    }
                }
            }
        }
        self.performSegue(withIdentifier: "ObjectToObjectSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

typealias OtherObjectFunctions = ObjectViewController
extension OtherObjectFunctions{
    
    func setType(){
        guard let type = self.objectType else{return}
        
        switch type {
        case .film:
            guard let f = self.object as? Film else{return}
            self.film = f
            guard let sub1 = self.objectSubVals1 as? [Person] else{return}
            print(sub1.count)
            self.cFilmCharacters = sub1
            guard let sub2 = self.objectSubVals2 as? [Planet] else{return}
            print(sub2.count)
            self.cFilmPlanets = sub2
            guard let sub3 = self.objectSubVals3 as? [Specie] else{return}
            print(sub3.count)
            self.cFilmSpecies = sub3
            guard let sub4 = self.objectSubVals4 as? [Starship] else{return}
            print(sub4.count)
            self.cFilmStarships = sub4
            guard let sub5 = self.objectSubVals5 as? [Vehicle] else{return}
            print(sub5.count)
            self.cFilmVehicles = sub5
        case .character:
            guard let c = self.object as? Person else{return}
            self.character = c
            guard let hw = self.objectSubValHomeworld as? Planet else{return}
            print(1)
            self.cCharacterHomeworld = hw
            guard let sub1 = self.objectSubVals1 as? [Film] else{return}
            print(sub1.count)
            self.cCharacterFilms = sub1
            guard let sub2 = self.objectSubVals2 as? [Specie] else{return}
            print(sub2.count)
            self.cCharacterSpecies = sub2
            guard let sub3 = self.objectSubVals3 as? [Starship] else{return}
            print(sub3.count)
            self.cCharacterStarships = sub3
            guard let sub4 = self.objectSubVals4 as? [Vehicle] else{return}
            print(sub4.count)
            self.cCharacterVehicles = sub4
        case .planet:
            guard let p = self.object as? Planet else{return}
            self.planet = p
            guard let sub1 = self.objectSubVals1 as? [Person] else{return}
            print(sub1.count)
            self.cPlanetResidents = sub1
            guard let sub2 = self.objectSubVals2 as? [Film] else{return}
            print(sub2.count)
            self.cPlanetFilms = sub2
        case .species:
            guard let sp = self.object as? Specie else{return}
            self.species = sp
            guard let hw = self.objectSubValHomeworld as? Planet else{return}
            print(1)
            self.cSpeciesHomeworld = hw
            guard let sub1 = self.objectSubVals1 as? [Person] else{return}
            print(sub1.count)
            self.cSpeciesCharacters = sub1
            guard let sub2 = self.objectSubVals2 as? [Film] else{return}
            print(sub2.count)
            self.cSpeciesFilms = sub2
        case .starship:
            guard let st = self.object as? Starship else{return}
            self.starship = st
            guard let sub1 = self.objectSubVals1 as? [Person] else{return}
            print(sub1.count)
            self.cStarshipPilots = sub1
            guard let sub2 = self.objectSubVals2 as? [Film] else{return}
            print(sub2.count)
            self.cStarshipFilms = sub2
        default:
            guard let v = self.object as? Vehicle else{return}
            self.vehicle = v
            guard let sub1 = self.objectSubVals1 as? [Person] else{return}
            print(sub1.count)
            self.cVehiclePilots = sub1
            guard let sub2 = self.objectSubVals2 as? [Film] else{return}
            print(sub2.count)
            self.cVehicleFilms = sub2
        }
    }
    
    func callNetwork(_ url:URL,_ type:ObjectType, completion:@escaping(Any)->()){
        Networking.getAPI(url, ObjectListType.nothing, type){
            (object, error) in
            guard error==nil else{return}

            switch type{
            case .film:
                guard let val = object as? Film else{return}
                self.nFilms?.append(val)
                completion(val)
            case .character:
                guard let val = object as? Person else{return}
                self.nCharacter?.append(val)
                completion(val)
            case .planet:
                guard let val = object as? Planet else{return}
                self.nPlanets?.append(val)
                completion(val)
            case .species:
                guard let val = object as? Specie else{return}
                self.nSpecies?.append(val)
                completion(val)
            case .starship:
                guard let val = object as? Starship else{return}
                self.nStarships?.append(val)
                completion(val)
            default:
                guard let val = object as? Vehicle else{return}
                self.nVehicles?.append(val)
                completion(val)
            }


        }
    }
    
    func insertData(){
        guard let type = objectType else{return}
        
        objectImage.image = #imageLiteral(resourceName: "Default")
        
        firstLabel.textColor = UIColor.red
        secondLabel.textColor = UIColor.red
        thirdLabel.textColor = UIColor.red
        fourthLabel.textColor = UIColor.red
        fifthLabel.textColor = UIColor.red
        sixthLabel.textColor = UIColor.red
        seventhLabel.textColor = UIColor.red
        eighthLabel.textColor = UIColor.red
        ninethLabel.textColor = UIColor.red
        tenthLabel.textColor = UIColor.red
        eleventhLabel.textColor = UIColor.red
        twelvthLabel.textColor = UIColor.red
        thirteenthLabel.textColor = UIColor.red
        
        switch type {
        case .film:
            guard let f = film else{return}
            
            objectImage.imageFrom(url: Networking.imageURLBase+f.title.removingWhitespaces()+".png", queue: operationQueue)
            
            firstLabel.text = "Episode \(f.episode_id): \(f.title)"
            secondLabel.text = "\(f.release_date)"
            thirdLabel.text = "Director(s): \(f.director)"
            fourthLabel.text = "Producer(s): \(f.producer)"
            fifthLabel.text = ""
            sixthLabel.text = ""
            seventhLabel.text = ""
            eighthLabel.text = ""
            ninethLabel.text = ""
            tenthLabel.text = ""
            eleventhLabel.text = ""
            twelvthLabel.text = ""
            thirteenthLabel.text = ""
            
        case .character:
            guard let c = character else{return}
            
            objectImage.imageFrom(url: Networking.imageURLBase+c.name.removingWhitespaces()+".png", queue: operationQueue)
            
            firstLabel.text = c.name
            secondLabel.text = "Height: \(c.height) cm"
            thirdLabel.text = "Mass: \(c.mass) kg"
            fourthLabel.text = "Hair Color: \(c.hair_color)"
            fifthLabel.text = "Eye Color: \(c.eye_color)"
            sixthLabel.text = "Skin Color: \(c.skin_color)"
            seventhLabel.text = "Year of Birth: \(c.birth_year)"
            eighthLabel.text = "Gender: \(c.gender)"
            ninethLabel.text = ""
            tenthLabel.text = ""
            eleventhLabel.text = ""
            twelvthLabel.text = ""
            thirteenthLabel.text = ""
            
        case .planet:
            guard let p = planet else{return}
            
            objectImage.imageFrom(url: Networking.imageURLBase+p.name.removingWhitespaces()+".png", queue: operationQueue)
            
            firstLabel.text = p.name
            secondLabel.text = "Rotation Period: \(p.rotation_period) hrs"
            thirdLabel.text = "Orbital Period: \(p.orbital_period) days"
            fourthLabel.text = "Diameter: \(p.diameter) km"
            fifthLabel.text = "Climate: \(p.climate)"
            sixthLabel.text = "Gravity: \(p.gravity) G"
            seventhLabel.text = "Terrain: \(p.terrain)"
            eighthLabel.text = "Surface Water: \(p.surface_water)%"
            ninethLabel.text = "Population: ~\(p.population)"
            tenthLabel.text = ""
            eleventhLabel.text = ""
            twelvthLabel.text = ""
            thirteenthLabel.text = ""
            
        case .species:
            guard let sp = species else{return}
            
            objectImage.imageFrom(url: Networking.imageURLBase+sp.name.removingWhitespaces()+".png", queue: operationQueue)
            
            firstLabel.text = sp.name
            secondLabel.text = sp.classification
            thirdLabel.text = sp.designation
            fourthLabel.text = "Ave Height: \(sp.average_height) cm"
            fifthLabel.text = "Skin Colors: \(sp.skin_colors)"
            sixthLabel.text = "Hair Colors: \(sp.hair_colors)"
            seventhLabel.text = "Eye Colors: \(sp.eye_colors)"
            eighthLabel.text = "Ave LifeSpan: \(sp.average_lifespan) yrs"
            ninethLabel.text = "Language: \(sp.language)"
            tenthLabel.text = ""
            eleventhLabel.text = ""
            twelvthLabel.text = ""
            thirteenthLabel.text = ""
            
        case .starship:
            guard let st = starship else{return}
            
            objectImage.imageFrom(url: Networking.imageURLBase+st.name.removingWhitespaces()+".png", queue: operationQueue)
            
            firstLabel.text = st.name
            secondLabel.text = "Model: \(st.model)"
            thirdLabel.text = "Manufacturer: \(st.manufacturer)"
            fourthLabel.text = "Cost: \(st.cost_in_credits) credits"
            fifthLabel.text = "Length: \(st.length) m"
            sixthLabel.text = "Max Atm Speed: \(st.max_atmosphering_speed) km/h"
            seventhLabel.text = "Crew Size: ~\(st.crew)"
            eighthLabel.text = "Passengers: ~\(st.passengers)"
            ninethLabel.text = "Cargo Cap: ~\(st.cargo_capacity) kg"
            tenthLabel.text = "Consumables: \(st.consumables)"
            eleventhLabel.text = "HyperDive Rating: \(st.hyperdrive_rating)"
            twelvthLabel.text = "MGLT: \(st.MGLT) MGLT"
            thirteenthLabel.text = "Class: \(st.starship_class)"
            
        default:
            guard let v = vehicle else{return}
            
            objectImage.imageFrom(url: Networking.imageURLBase+v.name.removingWhitespaces()+".png", queue: operationQueue)
            
            firstLabel.text = v.name
            secondLabel.text = "Model: \(v.model)"
            thirdLabel.text = "Manufacturer: \(v.manufacturer)"
            fourthLabel.text = "Cost: \(v.cost_in_credits) credits"
            fifthLabel.text = "Length: \(v.length) m"
            sixthLabel.text = "Max Atm Speed: \(v.max_atmosphering_speed) km/h"
            seventhLabel.text = "Crew Size: ~\(v.crew)"
            eighthLabel.text = "Passengers: ~\(v.passengers)"
            ninethLabel.text = "Cargo Cap: ~\(v.cargo_capacity) kg"
            tenthLabel.text = "Consumables: \(v.consumables)"
            eleventhLabel.text = "Class: \(v.vehicle_class)"
            twelvthLabel.text = ""
            thirteenthLabel.text = ""
        }
        
        
    }
}


