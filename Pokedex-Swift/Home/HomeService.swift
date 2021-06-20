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
    
    static func getPokemonResults (_ idOrName: String, errorBinder: BehaviorRelay<Bool>) -> Observable<[Result]>{
        guard !idOrName.isEmpty else{
            return Observable.empty()
        }
        
        URLCache.shared.removeAllCachedResponses()
        return RxAlamofire.requestData(APIUrls.getPokemon(idOrName)).debug().catch { error in
            print(error)
            errorBinder.accept(true)
            
            return Observable.from([])
        }.map { (response, data) -> [Result] in
            print("Status Resposta: \(response.statusCode)")
            
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
               print("JSON: \(JSONString)")
            }
            
            do{
                let decoder = JSONDecoder()
                
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                let result = Result.init(name: pokemon.name ?? "", url: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name ?? "")")
                errorBinder.accept(false)
                return [result]
            }catch{
                errorBinder.accept(false)
                return []
            }
            
        }.asObservable()
    }
    
    static func getPokemonsList(errorBinder: BehaviorRelay<Bool>) -> Observable<[Result]>{
        
        URLCache.shared.removeAllCachedResponses()
        
        return RxAlamofire.requestData(APIUrls.getPokemons).debug().catch { error in
            print("Error ocurred \(error)")
            errorBinder.accept(true)
            return Observable.from([])
        }.map { (response, data) -> [Result] in
            print("Status Resposta: \(response.statusCode)")
            
            //TODO: Tratamento de erros
            let decoder = JSONDecoder()
            let page = try decoder.decode(Page.self, from: data)
            errorBinder.accept(false)
            return page.results
            
        }.asObservable()
        
    }
    
    static func getNextPage(offset: Int, limit: Int, errorBinder: BehaviorRelay<Bool>) -> Observable<[Result]>{
        
        URLCache.shared.removeAllCachedResponses()
        
        return RxAlamofire.requestData(APIUrls.getNextPage(offset, limit)).debug().catch { error in
            errorBinder.accept(true)
            return Observable.from([])
        }.map { (response, data) -> [Result] in
            print("Status Resposta: \(response.statusCode)")
            print("Página -> Offset: \(offset) | limit: \(limit)")
            
            //TODO: Tratamento de erros
            let decoder = JSONDecoder()
            let page = try decoder.decode(Page.self, from: data)
            errorBinder.accept(false)
            return page.results
            
        }.asObservable()
        
    }
    
    static func getPokemon(fromURL url: String) -> Observable<Pokemon>{
        
        guard let endpoint = URL.init(string: url) else{
            return Observable.empty()
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
