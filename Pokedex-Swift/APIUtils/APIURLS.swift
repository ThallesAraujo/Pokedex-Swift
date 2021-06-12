//
//  APIURLS.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import Foundation
import RxAlamofire
import Alamofire

enum APIUrls: URLRequestConvertible {
    
    static let baseURLString = "https://pokeapi.co/api/v2"

    case createUser([String: AnyObject])
    case readUser(String)
    case updateUser(String, [String: AnyObject])
    case destroyUser(String)
    case getPokemons
    case getPokemon(String)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .createUser:
            return .post
        case .readUser:
            return .get
        case .updateUser:
            return .put
        case .destroyUser:
            return .delete
        default:
            return .get
        }
    }
    

    var path: String {
        switch self {
        case .getPokemons:
            return "/pokemon"
        case .getPokemon(let idOrName):
            return "/pokemon/\(idOrName)"
        case .createUser:
            return "/pokemon"
        case .readUser(let username):
            return "/users/\(username)"
        case .updateUser(let username, _):
            return "/users/\(username)"
        case .destroyUser(let username):
            return "/users/\(username)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try APIUrls.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .createUser(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .updateUser(_, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }

        return urlRequest
    }
}

