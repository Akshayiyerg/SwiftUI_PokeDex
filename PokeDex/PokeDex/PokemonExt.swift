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
    
    var typeColor: Color {
        Color(types![0].capitalized)
    }
    
    var stats: [Stat] {
        [
            Stat(id: 1, name: "HP", value: hp),
            Stat(id: 2, name: "Attack", value: attack),
            Stat(id: 3, name: "Defence", value: defence),
            Stat(id: 4, name: "Special Attack", value: specialAttack),
            Stat(id: 5, name: "Special Defence", value: specialDefence),
            Stat(id: 6, name: "Speed", value: speed)
        ]
    }
    
    var highestStat: Stat {
        stats.max { $0.value < $1.value }!
    }
}

struct Stat: Identifiable {
    var id: Int
    var name: String
    var value: Int16
}
