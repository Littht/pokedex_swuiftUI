//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 31/7/23.
//

import SwiftUI

enum PkmnSection: CaseIterable {
    case about, stats, evolution
    
    var title: String {
        switch self {
        case .about:
            return "About"
        case .stats:
            return "Stats"
        case .evolution:
            return "Evolution"
        }
    }
}

struct PokemonDetails: View {
    var pokemonUrl = ""
    var pokemonName = ""
    @State private var pokemonInfo: PokemonSelected? = nil
    @State private var pokemonSpeciesInfo: PokemonSpecies? = nil
    @State private var selectedSection: PkmnSection = .about
    @State private var evolutionChain: EvolutionChain? = nil
    
    private let api = PokemonSelectedApi()
    
    struct ButtonStyle: SwiftUI.ButtonStyle {
        var isSelected: Bool
        var pokemonInfo: PokemonSelected?
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .background(isSelected ? (pokemonInfo?.types[0].type.name.color ?? .blue) : .clear)
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(10)
        }
    }
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("\(pokemonName.capitalized)")
                            .fontWeight(.bold)
                            .font(.system(size:30))
                            .foregroundColor(.white)
                            if let elements = pokemonInfo?.types {
                                HStack{
                                   ForEach(elements, id: \.type.name) { element in
                                       Text(element.type.name.rawValue.capitalized)
                                           .foregroundColor(.white)
                                           .fontWeight(.bold)
                                           .font(.system(size:20))
                                           .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                           .background(element.type.name.color.brightness(-0.08))
                                           .cornerRadius(10)
                                   }
                               }
                            }
                    }
                    Spacer()
                    Text("#\(pokemonInfo?.id ?? 0)")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }
                AsyncImage(url: URL(string: pokemonInfo?.sprites.other.officialArtwork.front_default ?? "")){ image in
                    image
                        .resizable()
                        .frame(width: 220, height: 220)
                        .padding(EdgeInsets(top: -20, leading: -90, bottom: -40, trailing: -90))
                }placeholder: {
                    Text("...Cargando")
                }
            }
            .zIndex(2)
            .padding(.horizontal,20)
            
            VStack{
                HStack {
                     ForEach(PkmnSection.allCases, id: \.self) { section in
                         Button {
                               selectedSection = section
                         } label: {
                             Text(section.title)
                                 .font(.system(size:20))
                         }
                         .buttonStyle(ButtonStyle(isSelected: selectedSection == section,  pokemonInfo: pokemonInfo))
                         .padding(.top, 20)
                     }
                }
                if selectedSection == .about {
                    ScrollView{
                            VStack{
                                HStack{
                                    Text("Height:")
                                        .foregroundColor(.gray)
                                        .font(.system(size:20))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                                    Text(" \(pokemonInfo?.height ?? 0)")
                                        .font(.system(size:20))
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 0))
                                HStack{
                                    Text("Weight:")
                                        .foregroundColor(.gray)
                                        .font(.system(size:20))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                                    Text(" \(pokemonInfo?.weight ?? 0)")
                                        .font(.system(size:20))
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 0))
                                HStack{
                                    Text("Base experience:")
                                        .foregroundColor(.gray)
                                        .font(.system(size:20))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                                    Text(" \(pokemonInfo?.base_experience ?? 0)")
                                        .font(.system(size:20))
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 0))
                                HStack{
                                    Text("Abilities:")
                                        .foregroundColor(.gray)
                                        .font(.system(size:20))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                                    let abilities = pokemonInfo?.abilities.map{$0.ability.name.replacingOccurrences(of: "-", with: " ").capitalized
                                    }.joined(separator: ", ")
                                    Text(abilities ?? "")
                                        .font(.system(size:20))
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 0))
                                HStack{
                                    Text("Base hapiness:")
                                        .foregroundColor(.gray)
                                        .font(.system(size:20))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                                    Text(" \(pokemonSpeciesInfo?.base_happiness ?? 0)")
                                        .font(.system(size:20))
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 0))
                                HStack{
                                    Text("Capture rate:")
                                        .foregroundColor(.gray)
                                        .font(.system(size:20))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                                    Text(" \(pokemonSpeciesInfo?.capture_rate ?? 0)")
                                        .font(.system(size:20))
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 0))
                                HStack{
                                    Text("Egg Groups:")
                                        .foregroundColor(.gray)
                                        .font(.system(size:20))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                                    let eggs = pokemonSpeciesInfo?.egg_groups.map{
                                        $0.name.capitalized
                                    }.joined(separator: ", ")
                                    Text(eggs ?? "")
                                        .font(.system(size:20))
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 0))
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        }
                } else if selectedSection == .stats {
                    if let baseStats = pokemonInfo?.stats{
                        ScrollView{
                            VStack{
                                ForEach(baseStats, id:\.stat.name){stat in
                                    HStack{
                                        Text(stat.stat.name.uppercased().replacingOccurrences(of: "-", with:" "))
                                            .font(.system(size:20))
                                            .foregroundColor(.gray)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                        Text("\(Int(stat.base_stat))")
                                        Spacer()
                                        ProgressView(newPercent: stat.base_stat, color: stat.color)
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        }
                    }
                    
                }
                else {
                    NavigationStack {
                        List {
                            if let evolution1 = evolutionChain?.chain.species.name.capitalized {
                                HStack {
                                    Spacer()
                                    VStack {
                                        let urlImage =  evolutionChain?.chain.species.url.replacingOccurrences(of: "pokemon-species", with: "pokemon")
                                        PokemonImage(imageLink: "\(urlImage ?? "")")
                                        Text("Base \(evolution1)")
                                    }
                                    Spacer()
                                }
                                .listRowBackground(Color.white)
                                .padding()
                            }
                            
                            evolutionStack(url: evolutionChain?.chain.evolves_to ?? [], isLast: (evolutionChain?.chain.evolves_to.first?.evolves_to ?? []).isEmpty, evolutionLvl: 1)
                            //evolutionChain?.chain.evolves_to ?? []
                            evolutionStack(url: evolutionChain?.chain.evolves_to.first?.evolves_to ?? [], isLast: (evolutionChain?.chain.evolves_to.first?.evolves_to.first?.evolves_to ?? []).isEmpty, evolutionLvl: 2)
                        }
                        .padding(.bottom, 30)
                        .background(Color.white)
                    }
                    .background(Color.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding(.bottom, -40)
            .zIndex(1)
            .foregroundColor(.black)
        }
        .onAppear{
            getData(url: pokemonUrl)            
        }
        .background(pokemonInfo?.types[0].type.name.color ?? .white)
    }
    
    func getData (url: String) {
        api.getData(url: url) { pokemon in
            pokemonInfo = pokemon
            self.getDataSpecies(url: self.pokemonInfo?.species.url ?? "")
        }
    }
    
    func getDataSpecies (url: String) {
        api.getDataSpecies(url: url) { pokemon in
            pokemonSpeciesInfo = pokemon
            self.getEvolutionChain(url: self.pokemonSpeciesInfo?.evolution_chain.url ?? "")
        }
    }
    
    func getEvolutionChain (url: String) {
        api.getEvolutionChain(url: url) { evolution in
            evolutionChain = evolution
        }
    }
    
    func getNamePokemon (nameUrl: [EvolvesTo]) -> some View {
        ForEach(nameUrl, id: \.species.name) { name in
            VStack{
                let urlImage = name.species.url.replacingOccurrences(of: "pokemon-species", with: "pokemon")
                PokemonImage(imageLink: urlImage)
                Text(name.species.name.capitalized)
            }
        }
    }

    func evolutionStack (url: [EvolvesTo], isLast: Bool = false, evolutionLvl: Int = 0) -> some View {
        ForEach(url, id: \.species.name) { evolution in
            HStack{
                if evolutionLvl == 1 {
                    VStack{
                        if let evolution = evolutionChain?.chain.species.name.capitalized {
                            let urlImage =  evolutionChain?.chain.species.url.replacingOccurrences(of: "pokemon-species", with: "pokemon")
                            PokemonImage(imageLink: "\(urlImage ?? "")")
                            Text(evolution)
                        }
                    }
                } else if evolutionLvl == 2 {
                    getNamePokemon(nameUrl: evolutionChain?.chain.evolves_to ?? [])
                }
                
                Spacer()
                
                evolutionDetailsFunction(evolution: evolution)
                
                Spacer()
                
                if let evolutionName = evolution.species.name.capitalized {
                    VStack{
                        let urlPkmn = evolution.species.url.replacingOccurrences(of: "pokemon-species", with: "pokemon")
                        PokemonImage(imageLink: "\(urlPkmn)")
                        NavigationLink("\(evolutionName)"){
                            PokemonDetails(pokemonUrl: "\(urlPkmn)", pokemonName: "\(evolutionName)")
                                .padding(.top,-50)
                        }
                    }
                }
            }
            .listRowBackground(Color.white)
            .padding()
        }
    }
    
    func evolutionDetailsFunction (evolution: EvolvesTo) -> some View {
        VStack{
            ForEach(Array(evolution.evolution_details.enumerated()), id: \.offset) { details in
                if let minLevel = details.element.min_level {
                    Text("At Level: \(minLevel)")
                }
                //                if let trigger = details.element.trigger {
                //                    Text(trigger.name)
                //                }
                if let minHappiness = details.element.min_happiness {
                    Text("Min Happiness: \(minHappiness)")
                }
                if let timeOfDay = details.element.time_of_day {
                    if !timeOfDay.isEmpty {
                        Text("Time of day: \(timeOfDay.capitalized)")
                    }
                }
                if let knowMoveType = details.element.known_move_type {
                    Text("Know Move Type: \(knowMoveType.name.capitalized)")
                }
                if let item = details.element.item {
                    Text("Item: \(item.name.replacingOccurrences(of: "-", with: " ").capitalized)")
                }
                if let minAffection = details.element.min_affection {
                    Text("Min Affection: \(minAffection)")
                }
                if let location = details.element.location{
                    Text("Location: \(location.name.replacingOccurrences(of: "-", with: " ").capitalized)")
                }
            }
        }
    }
}

struct PokemonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetails(pokemonUrl:"https://pokeapi.co/api/v2/pokemon/133/",pokemonName:"Eevee")
    }
}
