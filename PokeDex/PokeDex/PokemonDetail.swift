//
//  PokemonDetail.swift
//  PokeDex
//
//  Created by Akshay  on 2025-04-09.
//

import SwiftUI

struct PokemonDetail: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var pokemon: Pokemon
    
    @State private var showShiny = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(.normalgrasselectricpoisonfairy)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black ,radius: 6)
            }
        }
        .navigationTitle(pokemon.name!.capitalized)
    }
}

#Preview {
    NavigationStack {
        PokemonDetail()
            .environmentObject(PersistenceController.previewPokemon)
    }
}
