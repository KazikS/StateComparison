//
//  Store.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//
import Foundation
import Combine


@MainActor
final class Store: ObservableObject {
    @Published private(set) var state = AppState()

    func dispatch(_ action: AppAction) {
        appReducer(state: &state, action: action)
    }

    func loadCharacters() async {
        dispatch(.loadCharacters)
        do {
            let characters = try await APIClient.shared.fetchCharacters()
            dispatch(characters.isEmpty ? .charactersEmpty : .charactersLoaded(characters))
        } catch {
            dispatch(.loadFailed((error as? APIError)?.errorDescription ?? error.localizedDescription))
        }
    }
}
