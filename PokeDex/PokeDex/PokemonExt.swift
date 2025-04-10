//
//  PokemonExt.swift
//  PokeDex
//
//  Created by Akshay  on 2025-04-09.
//

import SwiftUI

extension Pokemon {
    var background: ImageResource {
        switch types![0] {
        case "rock", "ground", "steel", "fighting", "ghost", "dark", "psychic":
                .rockgroundsteelfightingghostdarkpsychic
        case "fire", "dragon":
                .firedragon
        case "flying", "bug":
                .flyingbug
        case "ice":
                .ice
        case "water":
                .water
        default:
                .normalgrasselectricpoisonfairy
                
        }
    }
}
