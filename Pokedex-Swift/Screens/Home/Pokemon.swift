// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemon = try? newJSONDecoder().decode(Pokemon.self, from: jsonData)

import Foundation

// MARK: - Pokemon
class Pokemon: Codable {
    let abilities: [AbilityDTO]?
    let baseExperience: Int?
    let forms: [Species]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let heldItems: [HeldItem]?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let pastTypes: [JSONAny]?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case pastTypes = "past_types"
        case species, sprites, stats, types, weight
    }

    init(abilities: [AbilityDTO]?, baseExperience: Int?, forms: [Species]?, gameIndices: [GameIndex]?, height: Int?, heldItems: [HeldItem]?, id: Int?, isDefault: Bool?, locationAreaEncounters: String?, moves: [Move]?, name: String?, order: Int?, pastTypes: [JSONAny]?, species: Species?, sprites: Sprites?, stats: [Stat]?, types: [TypeElement]?, weight: Int?) {
        self.abilities = abilities
        self.baseExperience = baseExperience
        self.forms = forms
        self.gameIndices = gameIndices
        self.height = height
        self.heldItems = heldItems
        self.id = id
        self.isDefault = isDefault
        self.locationAreaEncounters = locationAreaEncounters
        self.moves = moves
        self.name = name
        self.order = order
        self.pastTypes = pastTypes
        self.species = species
        self.sprites = sprites
        self.stats = stats
        self.types = types
        self.weight = weight
    }
}

extension Pokemon{
    
    func getImagesList() -> [String?]{

        return [
            self.sprites?.frontDefault,
            self.sprites?.backDefault,
            self.sprites?.frontFemale,
            self.sprites?.backFemale,
            self.sprites?.frontShiny,
            self.sprites?.backShiny,
            self.sprites?.frontShinyFemale,
            self.sprites?.backShinyFemale
        ]
        
    }
    
}


// MARK: - Ability
class AbilityDTO: Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }

    init(ability: Species?, isHidden: Bool?, slot: Int?) {
        self.ability = ability
        self.isHidden = isHidden
        self.slot = slot
    }
}

// MARK: - Species
class Species: Codable {
    let name: String?
    let url: String?

    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

extension Species{
    
    func asResult() -> Result{
        return Result.init(name: self.name ?? "", url: self.url ?? "")
    }
    
}

// MARK: - GameIndex
class GameIndex: Codable {
    let gameIndex: Int?
    let version: Species?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }

    init(gameIndex: Int?, version: Species?) {
        self.gameIndex = gameIndex
        self.version = version
    }
}

// MARK: - HeldItem
class HeldItem: Codable {
    let item: Species?
    let versionDetails: [VersionDetail]?

    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }

    init(item: Species?, versionDetails: [VersionDetail]?) {
        self.item = item
        self.versionDetails = versionDetails
    }
}

// MARK: - VersionDetail
class VersionDetail: Codable {
    let rarity: Int?
    let version: Species?

    init(rarity: Int?, version: Species?) {
        self.rarity = rarity
        self.version = version
    }
}

// MARK: - Move
class Move: Codable {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }

    init(move: Species?, versionGroupDetails: [VersionGroupDetail]?) {
        self.move = move
        self.versionGroupDetails = versionGroupDetails
    }
}

// MARK: - VersionGroupDetail
class VersionGroupDetail: Codable {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: Species?

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }

    init(levelLearnedAt: Int?, moveLearnMethod: Species?, versionGroup: Species?) {
        self.levelLearnedAt = levelLearnedAt
        self.moveLearnMethod = moveLearnMethod
        self.versionGroup = versionGroup
    }
}

// MARK: - GenerationV
class GenerationV: Codable {
    let blackWhite: Sprites?

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }

    init(blackWhite: Sprites?) {
        self.blackWhite = blackWhite
    }
}

// MARK: - GenerationIv
class GenerationIv: Codable {
    let diamondPearl, heartgoldSoulsilver, platinum: Sprites?

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }

    init(diamondPearl: Sprites?, heartgoldSoulsilver: Sprites?, platinum: Sprites?) {
        self.diamondPearl = diamondPearl
        self.heartgoldSoulsilver = heartgoldSoulsilver
        self.platinum = platinum
    }
}

// MARK: - Versions
class Versions: Codable {
    let generationI: GenerationI?
    let generationIi: GenerationIi?
    let generationIii: GenerationIii?
    let generationIv: GenerationIv?
    let generationV: GenerationV?
    let generationVi: [String: GenerationVi]?
    let generationVii: GenerationVii?
    let generationViii: GenerationViii?

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }

    init(generationI: GenerationI?, generationIi: GenerationIi?, generationIii: GenerationIii?, generationIv: GenerationIv?, generationV: GenerationV?, generationVi: [String: GenerationVi]?, generationVii: GenerationVii?, generationViii: GenerationViii?) {
        self.generationI = generationI
        self.generationIi = generationIi
        self.generationIii = generationIii
        self.generationIv = generationIv
        self.generationV = generationV
        self.generationVi = generationVi
        self.generationVii = generationVii
        self.generationViii = generationViii
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault, backFemale, backShiny, backShinyFemale: String?
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
    let other: Other?
    let versions: Versions?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }

    init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?, other: Other?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }
}

// MARK: - GenerationI
class GenerationI: Codable {
    let redBlue, yellow: RedBlue?

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }

    init(redBlue: RedBlue?, yellow: RedBlue?) {
        self.redBlue = redBlue
        self.yellow = yellow
    }
}

// MARK: - RedBlue
class RedBlue: Codable {
    let backDefault, backGray, frontDefault, frontGray: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backGray = "back_gray"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
    }

    init(backDefault: String?, backGray: String?, frontDefault: String?, frontGray: String?) {
        self.backDefault = backDefault
        self.backGray = backGray
        self.frontDefault = frontDefault
        self.frontGray = frontGray
    }
}

// MARK: - GenerationIi
class GenerationIi: Codable {
    let crystal, gold, silver: Crystal?

    init(crystal: Crystal?, gold: Crystal?, silver: Crystal?) {
        self.crystal = crystal
        self.gold = gold
        self.silver = silver
    }
}

// MARK: - Crystal
class Crystal: Codable {
    let backDefault, backShiny, frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    init(backDefault: String?, backShiny: String?, frontDefault: String?, frontShiny: String?) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}

// MARK: - GenerationIii
class GenerationIii: Codable {
    let emerald: Emerald?
    let fireredLeafgreen, rubySapphire: Crystal?

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }

    init(emerald: Emerald?, fireredLeafgreen: Crystal?, rubySapphire: Crystal?) {
        self.emerald = emerald
        self.fireredLeafgreen = fireredLeafgreen
        self.rubySapphire = rubySapphire
    }
}

// MARK: - Emerald
class Emerald: Codable {
    let frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    init(frontDefault: String?, frontShiny: String?) {
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}

// MARK: - GenerationVi
class GenerationVi: Codable {
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }

    init(frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
}

// MARK: - GenerationVii
class GenerationVii: Codable {
    let icons: DreamWorld?
    let ultraSunUltraMoon: GenerationVi?

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }

    init(icons: DreamWorld?, ultraSunUltraMoon: GenerationVi?) {
        self.icons = icons
        self.ultraSunUltraMoon = ultraSunUltraMoon
    }
}

// MARK: - DreamWorld
class DreamWorld: Codable {
    let frontDefault: String?
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }

    init(frontDefault: String?, frontFemale: String?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
    }
}

// MARK: - GenerationViii
class GenerationViii: Codable {
    let icons: DreamWorld?

    init(icons: DreamWorld?) {
        self.icons = icons
    }
}

// MARK: - Other
class Other: Codable {
    let dreamWorld: DreamWorld?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }

    init(dreamWorld: DreamWorld?, officialArtwork: OfficialArtwork?) {
        self.dreamWorld = dreamWorld
        self.officialArtwork = officialArtwork
    }
}

// MARK: - OfficialArtwork
class OfficialArtwork: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }

    init(frontDefault: String?) {
        self.frontDefault = frontDefault
    }
}

// MARK: - Stat
class Stat: Codable {
    let baseStat, effort: Int?
    let stat: Species?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }

    init(baseStat: Int?, effort: Int?, stat: Species?) {
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
}

// MARK: - TypeElement
class TypeElement: Codable {
    let slot: Int?
    let type: Species?

    init(slot: Int?, type: Species?) {
        self.slot = slot
        self.type = type
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

