//
//  APIClient.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case httpError(statusCode: Int)
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Некорректный URL запроса."
        case .httpError(let code):
            switch code {
            case 404: return "Ресурс не найден (404). Проверьте URL."
            case 500...599: return "Ошибка сервера (\(code)). Попробуйте позже."
            default: return "Ошибка HTTP \(code)."
            }
        case .decodingFailed:
            return "Ошибка обработки данных от сервера."
        }
    }
}


struct APIClient {
    static let shared = APIClient()
    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchCharacters(page: Int = 1) async throws -> [Character] {
        guard let url = URL(string: "\(baseURL)/character?page=\(page)") else {
            throw APIError.invalidURL
        }
        // Искусственная задержка: нужна, чтобы состояние .loading было
        // заметно на экране при демонстрации работы приложения.
        try await Task.sleep(for: .seconds(2))
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse else {
            throw APIError.httpError(statusCode: 0)
        }
        guard (200..<300).contains(http.statusCode) else {
            throw APIError.httpError(statusCode: http.statusCode)
        }
        do {
            return try JSONDecoder().decode(CharactersResponse.self, from: data).results
        } catch {
            throw APIError.decodingFailed
        }
    }
}
