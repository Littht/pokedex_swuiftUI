//
//  Pokemon.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 26/7/23.
//

import Foundation

struct Pokemons: Codable {
    var results: [PokemonStruct]
}

struct PokemonStruct: Codable, Identifiable{
    let id = UUID()
    var name: String
    var url: String
}

class PokeApi {
    func getData(completion: @escaping (([PokemonStruct]) -> ())){
        guard let url = URL(string:"https://pokeapi.co/api/v2/pokemon?limit=151") else{
            return
        }
        
        URLSession.shared.dataTask(with: url){(data,response,error) in
            guard let data = data else {return}
            
            let pokemonList = try! JSONDecoder().decode(Pokemons.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
}
