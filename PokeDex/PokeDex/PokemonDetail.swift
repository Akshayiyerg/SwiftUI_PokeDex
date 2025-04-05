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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PokemonDetail()
        .environmentObject(PersistenceController.previewPokemon)
}
