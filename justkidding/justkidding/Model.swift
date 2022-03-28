//
//  Model.swift
//  justkidding
//
//  Created by Vishank Raghav on 28/03/22.
//

import Foundation

// MARK: - Welcome
struct Joke: Codable {
    let error: Bool?
    let category, type, setup, delivery, joke: String?
    let flags: Flags?
    let id: Int?
    let safe: Bool?
    let lang: String?
}

// MARK: - Flags
struct Flags: Codable {
    let nsfw, religious, political, racist: Bool?
    let sexist, explicit: Bool?
}
