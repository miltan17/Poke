//
//  ViewController.swift
//  Poke
//
//  Created by Miltan on 12/21/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var audioPlayer: AVAudioPlayer!
    let path = Bundle.main.path(forResource: "song", ofType: "mp3")
    
    var pokemons = [Pokemon]()
    var searchedPokemons = [Pokemon]()
    
    var isSearchMode = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        pursePokemonFromCSV()
        
        initAudioPlayer()
    }
    
    
    // MAEK: - Audio Player
    
    func initAudioPlayer(){
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            audioPlayer.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        }catch{
            print(error)
        }
    }
    
    @IBAction func playPauseAudio(_ sender: UIButton) {
        
        if audioPlayer.isPlaying {
            sender.alpha = 0.6
            audioPlayer.pause()
            
        }else{

            audioPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    
   
    //MARK: - Data Handling
    
    func pursePokemonFromCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do{
            let csvData = try  CSV(contentsOfURL: path!)
            let rows = csvData.rows
            for row in rows{
                let pokemon = Pokemon(name: row["identifier"]!, id: Int(row["id"]!)!)
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
        
        if isSearchMode {
            return searchedPokemons.count
        }else{
            return pokemons.count
    
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
            
            var pokemon: Pokemon!
            
            if isSearchMode{
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

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pokemon: Pokemon!
        if isSearchMode {
            pokemon = searchedPokemons[indexPath.row]
        }else{
            pokemon = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
    }
    
    
    // MARK: - SearchBar Implementation
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            
            isSearchMode = false
            view.endEditing(true)
        }else{
            
            isSearchMode = true
            searchedPokemons = pokemons.filter({$0.pokemonName.range(of: searchText.lowercased()) != nil })

            collectionView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        view.endEditing(true)
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC" {
            if let destinationVC = segue.destination as? PokemonDetailVC {
                
               destinationVC.pokemon = sender as? Pokemon
            }
        }
    }
}

















