//
//  ReduxCharacterListView.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import SwiftUI

struct ReduxCharacterListView: View {
    @StateObject private var store = Store()

    var body: some View {
        NavigationStack {
            content.navigationTitle("Redux Store")
        }
        .task {
            if case .idle = store.state.charactersState { await store.loadCharacters() }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch store.state.charactersState {
        case .idle, .loading:
            LoadingView()
        case .loaded(let characters):
            List(characters) { character in
                NavigationLink(value: character) { CharacterRow(character: character) }
            }
            .listStyle(.plain)
            .navigationDestination(for: Character.self) { CharacterDetailView(character: $0) }
        case .empty:
            EmptyStateView()
        case .failed(let message):
            ErrorStateView(message: message) { Task { await store.loadCharacters() } }
        }
    }
}
