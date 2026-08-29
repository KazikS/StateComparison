import XCTest
@testable import StateComparison

final class ReducerTests: XCTestCase {


    private func makeCharacter(id: Int) -> Character {
        Character(
            id: id,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Place(name: "Earth", url: ""),
            location: Place(name: "Citadel of Ricks", url: ""),
            image: "https://example.com/\(id).jpeg",
            episode: ["https://example.com/episode/1"]
        )
    }

    func testInitialStateIsIdle() {
        XCTAssertEqual(AppState().charactersState, .idle)
    }

    func testLoadCharactersSetsLoading() {
        var state = AppState()

        appReducer(state: &state, action: .loadCharacters)

        XCTAssertEqual(state.charactersState, .loading)
    }

    func testCharactersLoadedSetsLoadedWithData() {
        var state = AppState()
        let characters = [makeCharacter(id: 1), makeCharacter(id: 2)]

        appReducer(state: &state, action: .charactersLoaded(characters))

        XCTAssertEqual(state.charactersState, .loaded(characters))
    }

    func testCharactersEmptySetsEmpty() {
        var state = AppState()

        appReducer(state: &state, action: .charactersEmpty)

        XCTAssertEqual(state.charactersState, .empty)
    }

    func testLoadFailedSetsFailedWithMessage() {
        var state = AppState()

        appReducer(state: &state, action: .loadFailed("Ошибка сервера (500). Попробуйте позже."))

        XCTAssertEqual(state.charactersState, .failed("Ошибка сервера (500). Попробуйте позже."))
    }

    func testReducerIsPure() {
        let characters = [makeCharacter(id: 1)]

        var first = AppState()
        var second = AppState()
        appReducer(state: &first, action: .charactersLoaded(characters))
        appReducer(state: &second, action: .charactersLoaded(characters))

        XCTAssertEqual(first, second)
    }

    func testFullLoadingCycle() {
        var state = AppState()
        let characters = [makeCharacter(id: 1)]

        XCTAssertEqual(state.charactersState, .idle)

        appReducer(state: &state, action: .loadCharacters)
        XCTAssertEqual(state.charactersState, .loading)

        appReducer(state: &state, action: .charactersLoaded(characters))
        XCTAssertEqual(state.charactersState, .loaded(characters))
    }
    
    func testRetryAfterFailure() {
        var state = AppState()

        appReducer(state: &state, action: .loadFailed("Ошибка HTTP 503."))
        XCTAssertEqual(state.charactersState, .failed("Ошибка HTTP 503."))

        appReducer(state: &state, action: .loadCharacters)
        XCTAssertEqual(state.charactersState, .loading)

        appReducer(state: &state, action: .charactersLoaded([makeCharacter(id: 7)]))
        XCTAssertEqual(state.charactersState, .loaded([makeCharacter(id: 7)]))
    }
}
