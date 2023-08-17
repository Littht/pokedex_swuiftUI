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
    var other : Other
    struct Other: Codable {
        var home: Home
        struct Home: Codable {
            var front_default: String
        }
    }
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

struct PokemonSpeciesUrl: Codable{
    var url:String
}

struct PokemonSpecies: Codable{
    var base_happiness: Int
    var capture_rate: Int
}

enum TypeName: String, Codable{
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
    case fliying
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
    static let fliying = Color("fliying")
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
        case .fliying:
            return CustomColor.fliying
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

class PokemonSelectedApi{
    
    func getData(url:String, completion: @escaping ((PokemonSelected) -> ())){
        AF.request(url).responseDecodable(of: PokemonSelected.self){ response in
            switch response.result{
            case let .success(pokemon):
                DispatchQueue.main.async {
                    completion(pokemon)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getDataSpecies(url:String, completion: @escaping((PokemonSpecies) -> ())){
        AF.request(url).responseDecodable(of: PokemonSpecies.self){ response in
            switch response.result{
            case let .success(pokemon):
                DispatchQueue.main.sync {
                    completion(pokemon)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
