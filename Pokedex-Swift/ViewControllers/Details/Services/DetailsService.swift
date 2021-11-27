//
//  DetailsService.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 27/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class DetailsService: Service {
    
    func getPokemonEvolution (_ id: Int, errorBinder: BehaviorRelay<Bool>) -> Observable<Evolution?> {
        guard id > 0 else {
            return Observable.empty()
        }
        
        if !isConnected() {
            errorBinder.accept(true)
        }
        
        return RxAlamofire.requestData(APIUrls.getEvolutions(id)).debug().catch { error in
            print(error)
            errorBinder.accept(true)
            return Observable.from([])
        }.map { (_, data) -> Evolution? in
            do {
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                   print("Evolucoes: \(JSONString)")
                }
                
                let decoder = JSONDecoder()
                let evolution = try decoder.decode(Evolution.self, from: data)
                errorBinder.accept(false)
                return evolution
            } catch {
                errorBinder.accept(false)
                return nil
            }
            
        }.asObservable()
    }
    
    func getAbility(fromURL url: String) -> Observable<Ability> {
        
        guard let endpoint = URL.init(string: url) else {
            return Observable.empty()
        }
        let request = URLRequest.init(url: endpoint)
        return RxAlamofire.requestData(request).debug().timeout(.seconds(3), scheduler: MainScheduler.instance).catch { error in
            print(error)
            return Observable.never()
        }.map { (_, data) in
            let decoder = JSONDecoder()
            let ability = try decoder.decode(Ability.self, from: data)
            return ability
        }.asObservable()
        
    }
    
}
