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
    
    static func getPokemonResults (_ idOrName: String) -> Observable<[Pokemon]>{
        guard !idOrName.isEmpty else{
            return Observable.never()
        }
        
        return RxAlamofire.requestData(APIUrls.getPokemon(idOrName)).debug().catch { error in
            print(error)
            return Observable.never()
        }.map { (response, data) -> [Pokemon] in
            print("Status Resposta: \(response.statusCode)")
            
            //TODO: Tratamento de erros
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            
            return [pokemon]
            
            
        }.asObservable()
        
    }
    
}
