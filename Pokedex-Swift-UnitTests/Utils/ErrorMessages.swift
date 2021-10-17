//
//  ErrorMessages.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 05/09/21.
//

import Foundation
class ErrorMessages {
    
    enum General: String {
        
        case emptyList = "A lista retornada é vazia"
        case notFound = "O elemento não foi encontrado"
        case castingError = "Não foi possível converter a resposta da rede para o tipo esperado"
    }
    
    enum Home: String {
        
        case pokemonNameDidntMatch = "O nome do Pokémon pesquisado não corresponde ao encontrado"
        case pokemonIDDidntMatch = "O ID do Pokémon pesquisado não corresponde ao encontrado"
        
    }
    
    enum PokemonTypes: String {
        case invalidType = "Tipo de Pokémon inválido"
    }
    
}
