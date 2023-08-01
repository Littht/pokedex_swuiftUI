//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 31/7/23.
//

import SwiftUI

struct PokemonImage: View {
    
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
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
            .clipShape(Circle())
            .foregroundColor(.gray.opacity(0.6))
    }
    
    func getSprite(url: String){
        var sprite : String?
        
        PokemonSelectedApi().getData(url: url){ getSprite in
            sprite = getSprite.front_default
            self.pokemonSprite = sprite ?? "algo"
        }
    }
    
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
