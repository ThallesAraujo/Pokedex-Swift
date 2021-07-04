// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonType = try? newJSONDecoder().decode(PokemonType.self, from: jsonData)

import Foundation

// MARK: - PokemonType
class PokemonType: Codable {
    let damageRelations: DamageRelations?
    let gameIndices: [GameIndex]?
    let generation: Generation?
    let id: Int?
    let moveDamageClass: Generation?
    let moves: [Generation]?
    let name: String?
    let names: [Name]?
    let pokemon: [PokemonTypeDTO]?

    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
        case gameIndices = "game_indices"
        case generation, id
        case moveDamageClass = "move_damage_class"
        case moves, name, names, pokemon
    }

    init(damageRelations: DamageRelations?, gameIndices: [GameIndex]?, generation: Generation?, id: Int?, moveDamageClass: Generation?, moves: [Generation]?, name: String?, names: [Name]?, pokemon: [PokemonTypeDTO]?) {
        self.damageRelations = damageRelations
        self.gameIndices = gameIndices
        self.generation = generation
        self.id = id
        self.moveDamageClass = moveDamageClass
        self.moves = moves
        self.name = name
        self.names = names
        self.pokemon = pokemon
    }
}

// MARK: - DamageRelations
class DamageRelations: Codable {
    let doubleDamageFrom: [Generation]?
    let doubleDamageTo, halfDamageFrom: [JSONAny]?
    let halfDamageTo, noDamageFrom, noDamageTo: [Generation]?

    enum CodingKeys: String, CodingKey {
        case doubleDamageFrom = "double_damage_from"
        case doubleDamageTo = "double_damage_to"
        case halfDamageFrom = "half_damage_from"
        case halfDamageTo = "half_damage_to"
        case noDamageFrom = "no_damage_from"
        case noDamageTo = "no_damage_to"
    }

    init(doubleDamageFrom: [Generation]?, doubleDamageTo: [JSONAny]?, halfDamageFrom: [JSONAny]?, halfDamageTo: [Generation]?, noDamageFrom: [Generation]?, noDamageTo: [Generation]?) {
        self.doubleDamageFrom = doubleDamageFrom
        self.doubleDamageTo = doubleDamageTo
        self.halfDamageFrom = halfDamageFrom
        self.halfDamageTo = halfDamageTo
        self.noDamageFrom = noDamageFrom
        self.noDamageTo = noDamageTo
    }
}

// MARK: - PokemonTypeDTO
class PokemonTypeDTO: Codable {
    let pokemon: Generation?
    let slot: Int?

    init(pokemon: Generation?, slot: Int?) {
        self.pokemon = pokemon
        self.slot = slot
    }
}


