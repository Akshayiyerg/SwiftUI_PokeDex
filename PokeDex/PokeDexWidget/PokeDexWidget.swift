//
//  PokeDexWidget.swift
//  PokeDexWidget
//
//  Created by Akshay  on 2025-04-17.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    var randomPokemon: Pokemon {
        var results: [Pokemon] = []
        
        do {
            results = try
            PersistenceController.shared.container.viewContext.fetch(Pokemon.fetchRequest())
        } catch {
            print("Couldn't fetch: \(error)")
        }
        
        if let randomPokemon = results.randomElement() {
            return randomPokemon
        }
        return PersistenceController.previewPokemon
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry.placeholder
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 10 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset * 5, to: currentDate)!
            
            let entryPokemon = randomPokemon
            
            let entry = SimpleEntry(date: entryDate,
                                    name: entryPokemon.name!,
                                    types: entryPokemon.types!,
                                    sprite: entryPokemon.spriteImage)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let name: String
    let types: [String]
    let sprite: Image
    
    static var placeholder: SimpleEntry {
        SimpleEntry(date: .now,
                    name: "bulbasaur",
                    types: ["grass", "poison"],
                    sprite: Image(.bulbasaur))
    }
    
    static var placeholder2: SimpleEntry {
        SimpleEntry(date: .now,
                    name: "mew",
                    types: ["psychic"],
                    sprite: Image(.mew))
    }
}

struct PokeDexWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var widgetSize
    var entry: Provider.Entry

    var pokemonImage: some View {
        entry.sprite
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .shadow(color: .black, radius: 6)
    }
    
    var typesView: some View {
        ForEach(entry.types, id: \.self) { type in
            Text(type.capitalized)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .padding(.horizontal, 13)
                .padding(.vertical, 5)
                .background(Color(type.capitalized))
                .clipShape(.capsule)
                .shadow(radius: 3)
        }
    }
    
    var body: some View {
        
        switch widgetSize {
            
        case .systemLarge:
            ZStack {
                pokemonImage
                
                VStack(alignment: .leading) {
                    Text(entry.name.capitalized)
                        .font(.largeTitle)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        typesView
                    }
                }
            }
        case .systemMedium:
            HStack {
                pokemonImage
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(entry.name.capitalized)
                        .font(.title)
                        .padding(.vertical, 1)
                    
                    HStack {
                        typesView
                    }
                }
                .layoutPriority(1)
                
                Spacer()
            }
        default:
            pokemonImage
        }
    }
}

struct PokeDexWidget: Widget {
    let kind: String = "PokeDexWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                PokeDexWidgetEntryView(entry: entry)
                    .foregroundStyle(.black)
                    .containerBackground(Color(entry.types[0].capitalized), for: .widget)
            } else {
                PokeDexWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Pokemon")
        .description("See a random Pokemon.")
    }
}

#Preview(as: .systemSmall) {
    PokeDexWidget()
} timeline: {
    SimpleEntry.placeholder
    SimpleEntry.placeholder2
}

#Preview(as: .systemMedium) {
    PokeDexWidget()
} timeline: {
    SimpleEntry.placeholder
    SimpleEntry.placeholder2
}

#Preview(as: .systemLarge) {
    PokeDexWidget()
} timeline: {
    SimpleEntry.placeholder
    SimpleEntry.placeholder2
}
