//
//  Pokemon.swift
//  Poke
//
//  Created by Miltan on 12/21/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import Foundation


class Pokemon {
    fileprivate var _pokemonName: String!
    fileprivate var _pokemonId: Int!
    
    var pokemonName: String {
        return _pokemonName
    }
    
    var pokemonId: Int{
        return _pokemonId
    }
    
    init(name: String, id: Int){
        self._pokemonName = name
        self._pokemonId = id
    }
}
