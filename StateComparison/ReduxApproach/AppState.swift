//
//  AppState.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import Foundation


struct AppState: Equatable {
    var charactersState: ViewState<[Character]> = .idle
}
