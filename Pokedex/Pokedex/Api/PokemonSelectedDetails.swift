//
//  PokemonSelectedDetails.swift
//  Pokedex
//
//  Created by Leonardo Benavides on 1/8/23.
//

//import Foundation
//import Alamofire
//
//struct pokemonSelectedDetails: Codable {
//    var sprites: PokemonSelectedSprites
//    var data: PokemonSelectedData
//}
//
//struct PokemonSelectedSprites: Codable {
//    var other : Other
//    struct Other: Codable {
//        var home: Home
//        struct Home: Codable {
//            var front_default: String
//        }
//    }
//}
//
//struct PokemonSelectedData: Codable {
//    var id: Int
//    var height: Int
//    var weight: Int
//    var base_experience: Int
//}
//
//
//class PokemonSelectedDetailsApi{
////    func getDataSprite(url:String, completion: @escaping((Result<PokemonSelectedSprites, Error>) -> Void)){
////        guard let url = URL(string:url) else{
////            return
////        }
////        URLSession.shared.dataTask(with: url){(data,response,error) in
////            guard let data = data else {return}
////
////            do{
////                let pokemon = try JSONDecoder().decode(pokemonSelectedDetails.self, from: data)
////
////                DispatchQueue.main.async {
////                    completion(.success(pokemon.sprites))
////                }
////            } catch{
////                completion(.failure(error))
////            }
////        }.resume()
////    }
//    func getDataSprite(url: String, completion: @escaping((PokemonSelectedSprites) -> ())) {
//        AF.request(url).responseDecodable(of: pokemonSelectedDetails.self){ response in
//            switch response.result{
//            case let .success(pokemon):
//                DispatchQueue.main.async{
//                    completion(pokemon.sprites)
//                }
//            case let .failure(error):
//                print(error)
//            }
//
//        }
//    }
//    func getData(url: String, completion: @escaping((PokemonSelectedData) -> Void)) {
//        AF.request(url).responseDecodable(of: pokemonSelectedDetails.self){response in
//            switch response.result{
//            case let .success(pokemon):
//                DispatchQueue.main.sync {
//                    completion(pokemon.data)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//}
