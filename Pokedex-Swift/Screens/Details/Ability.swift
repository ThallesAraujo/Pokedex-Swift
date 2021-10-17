// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let Ability = try? newJSONDecoder().decode(Ability.self, from: jsonData)

import Foundation

// MARK: - Ability
class Ability: Codable {
    let effectChanges: [EffectChange]?
    let effectEntries: [AbilityEffectEntry]?
    let flavorTextEntries: [FlavorTextEntry]?
    let generation: Generation?
    let id: Int?
    let isMainSeries: Bool?
    let name: String?
    let names: [Name]?
    let pokemon: [PokemonDTO]?

    enum CodingKeys: String, CodingKey {
        case effectChanges = "effect_changes"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id
        case isMainSeries = "is_main_series"
        case name, names, pokemon
    }

    init(effectChanges: [EffectChange]?,
         effectEntries: [AbilityEffectEntry]?,
         flavorTextEntries: [FlavorTextEntry]?,
         generation: Generation?,
         id: Int?,
         isMainSeries: Bool?,
         name: String?,
         names: [Name]?,
         pokemon: [PokemonDTO]?) {
        
        self.effectChanges = effectChanges
        self.effectEntries = effectEntries
        self.flavorTextEntries = flavorTextEntries
        self.generation = generation
        self.id = id
        self.isMainSeries = isMainSeries
        self.name = name
        self.names = names
        self.pokemon = pokemon
    }
}

// MARK: - EffectChange
class EffectChange: Codable {
    let effectEntries: [EffectChangeEffectEntry]?
    let versionGroup: Generation?

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case versionGroup = "version_group"
    }

    init(effectEntries: [EffectChangeEffectEntry]?, versionGroup: Generation?) {
        self.effectEntries = effectEntries
        self.versionGroup = versionGroup
    }
}

// MARK: - EffectChangeEffectEntry
class EffectChangeEffectEntry: Codable {
    let effect: String?
    let language: Generation?

    init(effect: String?, language: Generation?) {
        self.effect = effect
        self.language = language
    }
}

// MARK: - Generation
class Generation: Codable {
    let name: String?
    let url: String?

    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

// MARK: - AbilityEffectEntry
class AbilityEffectEntry: Codable {
    let effect: String?
    let language: Generation?
    let shortEffect: String?

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }

    init(effect: String?, language: Generation?, shortEffect: String?) {
        self.effect = effect
        self.language = language
        self.shortEffect = shortEffect
    }
}

// MARK: - FlavorTextEntry
class FlavorTextEntry: Codable {
    let flavorText: String?
    let language, versionGroup: Generation?

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }

    init(flavorText: String?, language: Generation?, versionGroup: Generation?) {
        self.flavorText = flavorText
        self.language = language
        self.versionGroup = versionGroup
    }
}

// MARK: - Name
class Name: Codable {
    let language: Generation?
    let name: String?

    init(language: Generation?, name: String?) {
        self.language = language
        self.name = name
    }
}

// MARK: - PokemonDTO
class PokemonDTO: Codable {
    let isHidden: Bool?
    let pokemon: Generation?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case pokemon, slot
    }

    init(isHidden: Bool?, pokemon: Generation?, slot: Int?) {
        self.isHidden = isHidden
        self.pokemon = pokemon
        self.slot = slot
    }
}
