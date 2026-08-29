//
//  NativeCharacterListView.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import SwiftUI

struct NativeCharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()

    var body: some View {
        NavigationStack {
            content.navigationTitle("Native State")
        }
        .task {
            if case .idle = viewModel.state { await viewModel.load() }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
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
            ErrorStateView(message: message) { Task { await viewModel.load() } }
        }
    }
}
