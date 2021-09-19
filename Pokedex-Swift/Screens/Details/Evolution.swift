// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let evolution = try? newJSONDecoder().decode(Evolution.self, from: jsonData)


import Foundation
// MARK: - Evolution
class Evolution: Codable {
    let babyTriggerItem: JSONNull?
    let chain: Chain?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain, id
    }

    init(babyTriggerItem: JSONNull?, chain: Chain?, id: Int?) {
        self.babyTriggerItem = babyTriggerItem
        self.chain = chain
        self.id = id
    }
}
// MARK: - Chain
class Chain: Codable, Hashable {
    
    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [Chain]?
    let isBaby: Bool?
    let species: Species?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(species?.name)
    }
    
    static func == (lhs: Chain, rhs: Chain) -> Bool {
        return lhs.species?.name == rhs.species?.name
    }

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }

    init(evolutionDetails: [EvolutionDetail]?, evolvesTo: [Chain]?, isBaby: Bool?, species: Species?) {
        self.evolutionDetails = evolutionDetails
        self.evolvesTo = evolvesTo
        self.isBaby = isBaby
        self.species = species
    }
}

// MARK: - EvolutionDetail
class EvolutionDetail: Codable {
    let gender, knownMove: JSONNull?
    let item, heldItem: Species?
    let knownMoveType, location, minAffection, minBeauty: JSONNull?
    let minHappiness: Int?
    let minLevel: Int?
    let needsOverworldRain: Bool?
    let partySpecies, partyType, relativePhysicalStats: JSONNull?
    let timeOfDay: String?
    let tradeSpecies: JSONNull?
    let trigger: Species?
    let turnUpsideDown: Bool?

    enum CodingKeys: String, CodingKey {
        case gender
        case heldItem = "held_item"
        case item
        case knownMove = "known_move"
        case knownMoveType = "known_move_type"
        case location
        case minAffection = "min_affection"
        case minBeauty = "min_beauty"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case partySpecies = "party_species"
        case partyType = "party_type"
        case relativePhysicalStats = "relative_physical_stats"
        case timeOfDay = "time_of_day"
        case tradeSpecies = "trade_species"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }

    init(gender: JSONNull?, heldItem: Species?, item: Species?, knownMove: JSONNull?, knownMoveType: JSONNull?, location: JSONNull?, minAffection: JSONNull?, minBeauty: JSONNull?, minHappiness: Int?, minLevel: Int?, needsOverworldRain: Bool?, partySpecies: JSONNull?, partyType: JSONNull?, relativePhysicalStats: JSONNull?, timeOfDay: String?, tradeSpecies: JSONNull?, trigger: Species?, turnUpsideDown: Bool?) {
        self.gender = gender
        self.heldItem = heldItem
        self.item = item
        self.knownMove = knownMove
        self.knownMoveType = knownMoveType
        self.location = location
        self.minAffection = minAffection
        self.minBeauty = minBeauty
        self.minHappiness = minHappiness
        self.minLevel = minLevel
        self.needsOverworldRain = needsOverworldRain
        self.partySpecies = partySpecies
        self.partyType = partyType
        self.relativePhysicalStats = relativePhysicalStats
        self.timeOfDay = timeOfDay
        self.tradeSpecies = tradeSpecies
        self.trigger = trigger
        self.turnUpsideDown = turnUpsideDown
    }
}
