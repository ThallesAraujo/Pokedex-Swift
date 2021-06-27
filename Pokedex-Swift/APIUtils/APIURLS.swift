//
//  APIURLS.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import Foundation
import Alamofire

enum APIUrls: URLRequestConvertible {
    
    static let baseURLString = "https://pokeapi.co/api/v2"
    static let getPokemonURL = "https://pokeapi.co/api/v2/pokemon/"

    case getPokemons
    case getPokemon(String)
    case getNextPage(Int, Int)
    case getEvolutions(Int)

    var method: Alamofire.HTTPMethod {
        return .get
    }
    

    var path: String {
        switch self {
        case .getPokemons:
            return "/pokemon"
        case .getPokemon(let idOrName):
            return "/pokemon/\(idOrName)"
        case .getNextPage(_, _):
            return "/pokemon"
        case .getEvolutions(let id):
            return "/evolution-chain/\(id)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try APIUrls.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .getNextPage(let offset, let limit):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["offset": offset, "limit": limit])
        default:
            break
        }

        return urlRequest
    }
}

