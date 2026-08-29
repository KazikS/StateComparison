//
//  CharacterListViewModel.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//
import Foundation
import Combine

@MainActor
final class CharacterListViewModel: ObservableObject {
    @Published var state: ViewState<[Character]> = .idle

    func load() async {
        state = .loading
        do {
            let characters = try await APIClient.shared.fetchCharacters()
            state = characters.isEmpty ? .empty : .loaded(characters)
        } catch let error as APIError {
            state = .failed(error.errorDescription ?? "Неизвестная ошибка.")
        } catch {
            state = .failed("Не удалось загрузить данные. Проверьте соединение.")
        }
    }
}
