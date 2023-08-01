//
//  PokemonSelectedDetails.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 1/8/23.
//

import Foundation

struct pokemonSelectedDetails: Codable{
    var sprites: PokemonSelectedSprites
}

struct PokemonSelectedSprites: Codable{
        var other : Other
        struct Other: Codable{
            var home: Home
            struct Home: Codable{
                var front_default: String
            }
        }
}

class PokemonSelectedDetailsApi{
    func getData(url:String, completion: @escaping((PokemonSelectedSprites) -> ())){
        guard let url = URL(string:url) else{
            return
        }
        URLSession.shared.dataTask(with: url){(data,response,error) in
            guard let data = data else {return}
            
            let pokemonSprite = try! JSONDecoder().decode(pokemonSelectedDetails.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
        }.resume()
    }
}
