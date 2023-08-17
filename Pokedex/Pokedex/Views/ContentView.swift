//
//  ContentView.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 26/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var pokemon = [PokemonStruct]()
    @State var search = ""
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(search == "" ? pokemon : pokemon.filter({
                    $0.name.contains(search.lowercased())
                })) {pokemon in
                    HStack{
                        PokemonImage(imageLink: "\(pokemon.url)")
                            .padding(.trailing, 20)
                        NavigationLink("\(pokemon.name.capitalized)") {
                            PokemonDetails(pokemonUrl: "\(pokemon.url)",pokemonName:"\(pokemon.name)")
                        }
                    }
                }
            }
            .searchable(text: $search)
            .navigationTitle("Pokedex")
        }
        .onAppear{
            PokeApi().getAlamofireRequest() { pokemon in
                self.pokemon = pokemon
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
