//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 31/7/23.
//

import SwiftUI

enum PkmnSection: CaseIterable {
    case about, stats
    
    var title: String {
        switch self {
        case .about:
            return "About"
        case .stats:
            return "Stats"
        }
    }
}

struct PokemonDetails: View {
    var pokemonUrl = ""
    var pokemonName = ""
    @State private var pokemonInfo: PokemonSelected? = nil
    @State private var pokemonSpeciesInfo: PokemonSpecies? = nil
    @State private var selectedSection: PkmnSection = .about

    private let api = PokemonSelectedApi()
    
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
                                           .fontWeight(.light)
                                           .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                           .background(.ultraThinMaterial,
                                                       in: RoundedRectangle(cornerRadius: 4, style: .continuous))
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
                AsyncImage(url: URL(string: pokemonInfo?.sprites.other.home.front_default ?? "")){ image in
                    image
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding(-40)
                }placeholder: {
                    Text("...Cargando")
                }
                .offset(y:20)
            }
            .zIndex(2)
            .padding(20)
            

            Spacer()
            VStack{
                HStack {
                     ForEach(PkmnSection.allCases, id: \.self) { section in
                         Button {
                               selectedSection = section
                         } label: {
                             Text(section.title)
                                 .font(.system(size:20))
                                 .foregroundColor(.black)
                         }
                         .padding(30)
                     }
                }
                if selectedSection == .about {
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
                    }
                } else {
                    if let baseStats = pokemonInfo?.stats{
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
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding(.bottom, -40)
            .zIndex(1)
        }
        .onAppear{
            getData(url: pokemonUrl)
            //getDataSpecies(url: pokemonInfo?.species.url ?? "")
            
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
        api.getDataSpecies(url: url){ pokemon in
            pokemonSpeciesInfo = pokemon
        }
    }
}

struct PokemonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetails(pokemonUrl:"https://pokeapi.co/api/v2/pokemon/4/",pokemonName:"Charmander")
    }
}
