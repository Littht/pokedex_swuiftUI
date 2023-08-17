//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 31/7/23.
//

import SwiftUI

struct PokemonImage: View {
    
    var imageLink = ""
    @State private var pokemon: PokemonSelected? = nil
    
    var body: some View {
        AsyncImage(url: URL(string: pokemon?.sprites.front_default ?? ""))
            .frame(width: 75, height: 75)
            .onAppear{
                getData(url: imageLink)
            }
            .clipShape(Circle())
            .foregroundColor(.gray.opacity(0.6))
    }
    
    func getData(url: String) {
        PokemonSelectedApi().getData(url: url){getSprite in
            pokemon = getSprite
            //self.pokemonSprite = getSprite.sprites.other.home.front_default
        }
    }
    
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(imageLink: "https://pokeapi.co/api/v2/pokemon/4/")
    }
}
