//
//  PokemonSelected.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 28/7/23.
//

import Foundation
import Alamofire
import SwiftUI


struct PokemonSelected: Codable {
    var sprites: PokemonSprites
    var id: Int
    var height: Int
    var weight: Int
    var base_experience: Int
    var types: [PokemonType]
    var abilities: [PokemonAbility]
    var stats: [BaseStats]
    var species: PokemonSpeciesUrl
}

struct PokemonSprites: Codable {
    var front_default: String
    var other: Other
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        struct OfficialArtwork: Codable {
            var front_default: String
        }
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case front_default
//        case other
//    }
}

struct PokemonType: Codable {
    var type: PkmnType
    struct PkmnType: Codable {
        var name: TypeName
    }
}

struct PokemonAbility: Codable {
    var ability: PkmnAbility
    struct PkmnAbility: Codable {
        var name: String
    }
}

struct BaseStats: Codable {
    var base_stat: CGFloat
    var stat: Stat
    struct Stat: Codable{
        var name: String
    }
}

struct PokemonSpeciesUrl: Codable {
    var url:String
}

struct PokemonSpecies: Codable {
    var base_happiness: Int
    var capture_rate: Int
    var egg_groups: [EggGroup]
    var evolution_chain: EvolutionUrl
}

struct EggGroup: Codable {
    var name:String
}

enum TypeName: String, Codable {
    case steel
    case water
    case bug
    case dragon
    case electric
    case ghost
    case fire
    case fairy
    case ice
    case fighting
    case normal
    case grass
    case psychic
    case rock
    case ground
    case dark
    case poison
    case flying
}

struct CustomColor {
    static let steel = Color("steel")
    static let water = Color("water")
    static let bug = Color("bug")
    static let dragon = Color("dragon")
    static let electric = Color("electric")
    static let ghost = Color("ghost")
    static let fire = Color("fire")
    static let fairy = Color("fairy")
    static let ice = Color("ice")
    static let fight = Color("fight")
    static let normal = Color("normal")
    static let grass = Color("grass")
    static let psychic = Color("psychic")
    static let rock = Color("rock")
    static let ground = Color("ground")
    static let dark = Color("dark")
    static let poison = Color("poison")
    static let flying = Color("fliying")
}

extension TypeName {
    var color: Color {
        switch self {
        case .steel:
            return CustomColor.steel
        case .water:
            return CustomColor.water
        case.bug:
            return CustomColor.bug
        case .dragon:
            return CustomColor.dragon
        case .electric:
            return CustomColor.electric
        case .ghost:
            return CustomColor.ghost
        case .fire:
            return CustomColor.fire
        case .ice:
            return CustomColor.ice
        case .fighting:
            return CustomColor.fight
        case .psychic:
            return CustomColor.psychic
        case .rock:
            return CustomColor.rock
        case .ground:
            return CustomColor.ground
        case .dark:
            return CustomColor.dark
        case .flying:
            return CustomColor.flying
        case .grass:
            return CustomColor.grass
        case .poison:
            return CustomColor.poison
        case .normal:
            return CustomColor.normal
        default:
            return .white
        }
    }
}

extension BaseStats {
    var color:Color{
        switch self.base_stat{
        case 0..<31:
            return .red
        case 31..<61:
            return .orange
        case 61..<81:
            return .yellow
        case 81..<131:
            return .green
        case 131...:
            return .blue
        default:
            return .white
        }
    }
}

struct EvolutionUrl: Codable {
    let url: String
}

struct EvolutionChain: Codable {
    let chain: Chain
    struct Chain: Codable {
        let evolution_details: [EvolutionDetails]
        let species: Species
        let evolves_to: [EvolvesTo]
    }
}

struct EvolvesTo: Codable {
    let species: Species
    let evolves_to: [EvolvesTo]
    let evolution_details: [EvolutionDetails]
}
struct Species: Codable {
    let name: String
    let url: String
}
struct EvolutionDetails: Codable {
    let gender: Int?
    let held_item: HeldItem?
    let item: Item?
    let known_move: KnownMove?
    let known_move_type: KnowMoveType?
    let location: Location?
    let min_affection: Int?
    let min_happiness: Int?
    let min_level: Int?
    let needs_overworld_rain: Bool
    let time_of_day: String
    let trigger: Trigger
}

// evolution details strucs
struct HeldItem: Codable {
    let name: String
    let url: String
}

struct Item: Codable{
    let name: String
    let url: String
}

struct KnownMove: Codable {
    let name: String
    let url: String
}

struct KnowMoveType: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}

struct Trigger: Codable {
    let name: String
    let url: String
}


class PokemonSelectedApi {
    
    func getData(url:String, completion: @escaping ((PokemonSelected) -> ())) {
        AF.request(url).responseDecodable(of: PokemonSelected.self) { response in
            switch response.result {
            case let .success(pokemon):
                completion(pokemon)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getDataSpecies(url: String, completion: @escaping((PokemonSpecies) -> ())) {
        AF.request(url).responseDecodable(of: PokemonSpecies.self) { response in
            switch response.result {
            case let .success(pokemon):
                completion(pokemon)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getEvolutionChain(url: String, completion: @escaping((EvolutionChain) -> ())) {
        AF.request(url).responseDecodable(of: EvolutionChain.self) { response in
            switch response.result {
            case let .success(pokemonEvolution):
                completion(pokemonEvolution)
            case let .failure(error):
                print(error)
            }            
        }
    }
}
