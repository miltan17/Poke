//
//  PokemonCell.swift
//  Poke
//
//  Created by Miltan on 12/21/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonId: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    
    func loadPokemonToTheView(pokemon: Pokemon){
        pokemonId.image = UIImage(named: "\(pokemon.pokemonId)")
        pokemonName.text = pokemon.pokemonName
    }
}
