//
//  AppAction.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import Foundation

// Действия — единственный способ изменить состояние.
enum AppAction {
    case loadCharacters
    case charactersLoaded([Character])
    case charactersEmpty
    case loadFailed(String)
}
