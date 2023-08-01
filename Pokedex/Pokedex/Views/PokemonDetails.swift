//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 31/7/23.
//

import SwiftUI

struct PokemonDetails: View {
    
    let name : String
    let url : String
    @State private var pokemonSprite = ""
    var imageLink = ""
    
    var body: some View {
        VStack{
            Text("\(name)")
            AsyncImage(url: URL(string: pokemonSprite))
                .frame(width: 200, height: 200)
                .onAppear{
                        let loadedData = UserDefaults.standard.string(forKey: imageLink)
        
                        if loadedData == nil {
                            getSprite(url: imageLink)
                            UserDefaults.standard.set(imageLink, forKey: imageLink)
                        }else{
                            getSprite(url: loadedData!)
                        }
                    getSprite(url: imageLink)
                }
        }
    }
    func getSprite(url: String){
        var sprite : String?
        
        PokemonSelectedDetailsApi().getData(url: url){ getSprite in
            sprite = getSprite.other.home.front_default
            self.pokemonSprite = sprite ?? "algo"
        }
    }
}

struct PokemonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetails(name: "ejemplo", url: "https://pokeapi.co/api/v2/pokemon/4/")
    }
}
