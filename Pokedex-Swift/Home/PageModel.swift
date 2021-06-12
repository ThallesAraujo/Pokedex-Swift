// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let page = try? newJSONDecoder().decode(Page.self, from: jsonData)

import Foundation

// MARK: - Page
class Page: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Result]

    init(count: Int, next: String, previous: JSONNull?, results: [Result]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

// MARK: - Result
class Result: Codable {
    let name: String
    let url: String

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
