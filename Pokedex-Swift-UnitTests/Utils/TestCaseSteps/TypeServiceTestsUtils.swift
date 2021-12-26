//
//  TypeServiceTestsUtils.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 26/09/21.
//

import Foundation
@testable import Pokedex_Swift
import XCTest
import RxSwift
import RxCocoa

extension TypeServiceTests {
    
    func getType(fromUrl url: String, andAssert assertion: @escaping (PokemonType) -> Void) {
        
        TypeServiceStubs.mockSuccessResponseStub()
        
        let type = TypeService().getType(fromURL: url, errorBinder: self.errorBinder)
        
        type.subscribe(onNext: {[weak self] pokemonType in
            assertion(pokemonType)
            guard let weakself = self else {return}
            weakself.expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
}
