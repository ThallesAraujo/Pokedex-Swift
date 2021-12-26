//
//  TypeServiceStubs.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 26/12/21.
//

import Foundation
import OHHTTPStubs
import Cuckoo
@testable import Pokedex_Swift

class TypeServiceStubs {
    
    static func mockSuccessResponseStub() {
        
        stub(condition: isMethodGET()) { request in
            
            let stubPath = OHPathForFile("PokemonType.json", TypeServiceStubs.self)
            
            return HTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers:    stubsDefaultHeaders)
        }
        
    }
}
