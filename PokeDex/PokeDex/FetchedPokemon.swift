//
//  FetchedPokemon.swift
//  PokeDex
//
//  Created by Akshay  on 2025-03-25.
//

import Foundation

struct FetchedPokemon: Decodable {
    let id: Int16
    let name: String
    let types: [String]
    let hp: Int16
    let attacks: Int16
    let defence: Int16
    let specialAttacks: Int16
    let specialDefence: Int16
    let speed: Int16
    let sprite: URL
    let shiny: URL
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictionaryKeys: CodingKey {
            case type
            
            enum TypeKeys: CodingKey {
                case name
            }
        }
        
        enum StatDictionaryKeys: CodingKey {
            case baseStat
        }
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "frontDefault"
            case shiny = "frontShiny"
        }
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.types = try container.decode([String].self, forKey: .types)
        self.hp = try container.decode(Int16.self, forKey: .hp)
        self.attacks = try container.decode(Int16.self, forKey: .attacks)
        self.defence = try container.decode(Int16.self, forKey: .defence)
        self.specialAttacks = try container.decode(Int16.self, forKey: .specialAttacks)
        self.specialDefence = try container.decode(Int16.self, forKey: .specialDefence)
        self.speed = try container.decode(Int16.self, forKey: .speed)
        self.sprite = try container.decode(URL.self, forKey: .sprite)
        self.shiny = try container.decode(URL.self, forKey: .shiny)
    }
}
