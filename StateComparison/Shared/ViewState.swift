//
//  ViewState.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import Foundation

// Один enum описывает ВСЕ состояния экрана.
// Невозможные комбинации («грузится И ошибка одновременно») просто невыразимы.
enum ViewState<Value: Equatable>: Equatable {
    case idle               // загрузку ещё не начинали
    case loading            // идёт запрос
    case loaded(Value)      // данные пришли
    case empty              // успех, но данных нет
    case failed(String)     // ошибка с сообщением для UI
}
