//
//  Character.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import Foundation

struct CharactersResponse: Codable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// Hashable — чтобы передавать персонажа как значение навигации.
// Identifiable — чтобы List различал строки по id.
struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Place
    let location: Place
    let image: String
    let episode: [String]
}

struct Place: Codable, Hashable {
    let name: String
    let url: String
}
