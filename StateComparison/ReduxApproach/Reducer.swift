//
//  Reducer.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import Foundation

// Чистая функция: (текущее состояние, действие) -> новое состояние.
// Никакой асинхронности и сети внутри — только преобразование данных.
func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .loadCharacters:               state.charactersState = .loading
    case .charactersLoaded(let chars):  state.charactersState = .loaded(chars)
    case .charactersEmpty:              state.charactersState = .empty
    case .loadFailed(let message):      state.charactersState = .failed(message)
    }
}
