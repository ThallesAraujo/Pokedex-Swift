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

class DetailsService: Service{
    
    static func getPokemonEvolution (_ id: Int, errorBinder: BehaviorRelay<Bool>) -> Observable<Evolution?>{
        guard id > 0 else{
            return Observable.empty()
        }
        
        if !isConnected(){
            errorBinder.accept(true)
        }
        
        return RxAlamofire.requestData(APIUrls.getEvolutions(id)).debug().catch { error in
            print(error)
            errorBinder.accept(true)
            return Observable.from([])
        }.map { (response, data) -> Evolution? in
            do{
                let decoder = JSONDecoder()
                let evolution = try decoder.decode(Evolution.self, from: data)
                errorBinder.accept(false)
                return evolution
            }catch{
                errorBinder.accept(false)
                return nil
            }
            
        }.asObservable()
    }
    
}
