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

class HomeService: Service {
    
    func getPokemonResults (_ idOrName: String, errorBinder: BehaviorRelay<Bool>) -> Observable<[Result]> {
        guard !idOrName.isEmpty else {
            return Observable.empty()
        }
        
        if !isConnected() {
            errorBinder.accept(true)
        }
        
        return RxAlamofire.requestData(APIUrls.getPokemon(idOrName)).debug().catch { error in
            print(error)
            errorBinder.accept(true)
            return Observable.from([])
        }.map { (_, data) -> [Result] in
            do {
                let decoder = JSONDecoder()
                
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                let result = Result.init(name: pokemon.name ?? "", url: APIUrls.getPokemonURL+(pokemon.name ?? ""))
                errorBinder.accept(false)
                return [result]
            } catch {
                errorBinder.accept(false)
                return []
            }
            
        }.asObservable()
    }
    
    func getPokemonsList(errorBinder: BehaviorRelay<Bool>) -> Observable<[Result]> {
        
        if !isConnected() {
            errorBinder.accept(true)
        }
        
        return RxAlamofire.requestData(APIUrls.getPokemons).debug().catch { _ in
            errorBinder.accept(true)
            return Observable.from([])
        }.map { (_, data) -> [Result] in
            let decoder = JSONDecoder()
            let page = try decoder.decode(Page.self, from: data)
            errorBinder.accept(false)
            return page.results
            
        }.asObservable()
        
    }
    
    func getNextPage(offset: Int, limit: Int, errorBinder: BehaviorRelay<Bool>) -> Observable<[Result]> {
        
        if !isConnected() {
            errorBinder.accept(true)
        }
        
        return RxAlamofire.requestData(APIUrls.getNextPage(offset, limit)).debug().catch { _ in
            errorBinder.accept(true)
            return Observable.from([])
        }.map { (_, data) -> [Result] in
            let decoder = JSONDecoder()
            let page = try decoder.decode(Page.self, from: data)
            errorBinder.accept(false)
            return page.results
            
        }.asObservable()
        
    }
    
    func getPokemon(fromURL url: String) -> Observable<Pokemon> {
        
        guard let endpoint = URL.init(string: url) else {
            return Observable.empty()
        }
        let request = URLRequest.init(url: endpoint)
        return RxAlamofire.requestData(request).debug().timeout(.seconds(3), scheduler: MainScheduler.instance).catch { error in
            print(error)
            return Observable.never()
        }.map { (_, data) in
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            return pokemon
        }.asObservable()
        
    }
    
}
