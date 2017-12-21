//
//  ViewController.swift
//  Poke
//
//  Created by Miltan on 12/21/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var searchedPokemons = [Pokemon]()
    
    var searchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        pursePokemonFromCSV()
    }
    
    //MARK: - Data Handling
    
    func pursePokemonFromCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do{
            let csvData = try  CSV(contentsOfURL: path!)
            let rows = csvData.rows
            for row in rows{
                var pokemon = Pokemon(name: row["identifier"]!, id: Int(row["id"]!)!)
                pokemons.append(pokemon)
            }
            collectionView.reloadData()
        }catch{
            print(error)
        }
    }
    
    
    // MARK: - CollectionView Implementation
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchMode {
            return searchedPokemons.count
        }else{
            return pokemons.count
    
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
            
            var pokemon: Pokemon!
            
            if searchMode{
                pokemon = searchedPokemons[indexPath.row]
            }else{
                pokemon = pokemons[indexPath.row]
            }
            
            cell.loadPokemonToTheView(pokemon: pokemon)
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }

    
    // MARK: - SearchBar Implementation
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            
            searchMode = false
            view.endEditing(true)
        }else{
            
            searchMode = true
            searchedPokemons = pokemons.filter({$0.pokemonName.range(of: searchText.lowercased()) != nil })

            collectionView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        view.endEditing(true)
    }
}

















