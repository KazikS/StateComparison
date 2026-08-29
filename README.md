# StateComparison

Курсовая работа. Сравнение подходов к управлению состоянием в iOS-приложении:
нативный (MVVM + SwiftUI) и Redux.

Сабанаев К. А., 254-334.

## Запуск

1. Открыть `StateComparison.xcodeproj` в Xcode 26.2 или новее.
2. Выбрать схему `StateComparison` и симулятор iPhone.
3. Cmd + R.

Зависимости и API-ключи не нужны. Нужен интернет — данные грузятся с сервера.

## Тесты

Cmd + U в Xcode.

## API

https://rickandmortyapi.com/api — публичный, без авторизации.

## Что внутри

Две вкладки — Native и Redux. Один и тот же экран со списком персонажей и
переходом в детали, но состояние в них управляется по-разному.

- `Shared/` — модель, сеть, `ViewState` (общее для обоих подходов)
- `Components/` — общие вью: строка списка, детали, экраны загрузки/ошибки/пустого
- `NativeStateApproach/` — ViewModel + View
- `ReduxApproach/` — State, Action, Reducer, Store + View
- `StateComparisonTests/` — тесты редьюсера
