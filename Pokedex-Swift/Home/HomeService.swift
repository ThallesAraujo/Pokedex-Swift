//
//  HomeService.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 12/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class HomeService{
    
    static func getPokemonResults (_ idOrName: String) -> Observable<[Result]>{
        guard !idOrName.isEmpty else{
            return Observable.never()
        }
        
        return RxAlamofire.requestData(APIUrls.getPokemon(idOrName)).debug().catch { error in
            print(error)
            return Observable.never()
        }.map { (response, data) -> [Result] in
            print("Status Resposta: \(response.statusCode)")
            
            //TODO: Tratamento de erros
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            
            let result = Result.init(name: pokemon.name, url: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)")
            
            return [result]
            
            
        }.asObservable()
    }
    
    static func getPokemonsList() -> Observable<[Result]>{
        
        return RxAlamofire.requestData(APIUrls.getPokemons).debug().catch { error in
            print(error)
            return Observable.never()
        }.map { (response, data) -> [Result] in
            print("Status Resposta: \(response.statusCode)")
            
            //TODO: Tratamento de erros
            let decoder = JSONDecoder()
            let page = try decoder.decode(Page.self, from: data)
            return page.results
            
        }.asObservable()
        
    }
    
    static func getNextPage(offset: Int, limit: Int) -> Observable<[Result]>{
        
        return RxAlamofire.requestData(APIUrls.getNextPage(offset, limit)).debug().catch { error in
            print(error)
            return Observable.never()
        }.map { (response, data) -> [Result] in
            print("Status Resposta: \(response.statusCode)")
            print("Página -> Offset: \(offset) | limit: \(limit)")
            
            //TODO: Tratamento de erros
            let decoder = JSONDecoder()
            let page = try decoder.decode(Page.self, from: data)
            return page.results
            
        }.asObservable()
        
    }
    
    static func getPokemon(fromURL url: String) -> Observable<Pokemon>{
        
        guard let endpoint = URL.init(string: url) else{
            return Observable.never()
        }
        let request = URLRequest.init(url: endpoint)
        return RxAlamofire.requestData(request).debug().catch { error in
            print(error)
            return Observable.never()
        }.map { (response, data) in
            print("Status Resposta: \(response.statusCode)")
            
            //TODO: Tratamento de erros
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            return pokemon
        }.asObservable()
        
    }
    
   
}
