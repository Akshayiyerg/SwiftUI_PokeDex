//
//  Stats.swift
//  PokeDex
//
//  Created by Akshay  on 2025-04-11.
//

import SwiftUI
import Charts

struct Stats: View {
    var pokemon: Pokemon
    
    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(
                x: .value("Value", stat.value),
                y: .value("Stat", stat.name)
            )
            
        }
    }
}

#Preview {
    Stats(pokemon: PersistenceController.previewPokemon)
}
