//
//  TypeService.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 03/07/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class TypeService: Service {
    
    static func getType(fromURL url: String, errorBinder: BehaviorRelay<Bool>) -> Observable<PokemonType> {
        
        if !isConnected() {
            errorBinder.accept(true)
        }
        
        guard let endpoint = URL.init(string: url) else {
            return Observable.empty()
        }
        let request = URLRequest.init(url: endpoint)
        return RxAlamofire.requestData(request).debug().catch { error in
            print(error)
            errorBinder.accept(true)
            return Observable.never()
        }.map { (_, data) in
            let decoder = JSONDecoder()
            let pokemonType = try decoder.decode(PokemonType.self, from: data)
            errorBinder.accept(false)
            return pokemonType
        }.asObservable()
        
    }
   
}
