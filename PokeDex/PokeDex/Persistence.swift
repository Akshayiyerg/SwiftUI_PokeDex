//
//  Persistence.swift
//  PokeDex
//
//  Created by Akshay  on 2025-03-19.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var previewPokemon: Pokemon {
        let context = PersistenceController.preview.container.viewContext
        
        // Fetching the Pokemon that is stored below this object from CoreData
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try! context.fetch(fetchRequest)
        
        return results.first!
    }

    
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let newPokemon = Pokemon(context: viewContext)
        newPokemon.id = 1
        newPokemon.name = "bulbasaur"
        newPokemon.types = ["grass", "poison"]
        newPokemon.hp = 45
        newPokemon.attack = 45
        newPokemon.defence = 49
        newPokemon.specialAttack = 65
        newPokemon.specialDefence = 65
        newPokemon.speed = 65
        newPokemon.sprite = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        newPokemon.shiny = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")
        
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PokeDex")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump // if any object it duplicate and we want to store it in the database CoreData will restore the existing one and deletes the duplicated one
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
