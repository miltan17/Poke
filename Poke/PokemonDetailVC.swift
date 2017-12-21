//
//  PokemonDetailVC.swift
//  Poke
//
//  Created by Miltan on 12/22/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func backButtonClicked(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
