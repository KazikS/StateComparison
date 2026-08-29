import XCTest
@testable import StateComparison

final class ViewStateTests: XCTestCase {

    func testStatesAreDistinct() {
        let states: [ViewState<[Int]>] = [.idle, .loading, .loaded([1]), .empty, .failed("error")]

        for (i, lhs) in states.enumerated() {
            for (j, rhs) in states.enumerated() where i != j {
                XCTAssertNotEqual(lhs, rhs)
            }
        }
    }

    func testLoadedCarriesValue() {
        let state = ViewState<[Int]>.loaded([1, 2, 3])

        guard case .loaded(let value) = state else {
            return XCTFail("Ожидалось состояние .loaded")
        }
        XCTAssertEqual(value, [1, 2, 3])
    }

    func testFailedCarriesMessage() {
        let state = ViewState<[Int]>.failed("Ошибка HTTP 404.")

        guard case .failed(let message) = state else {
            return XCTFail("Ожидалось состояние .failed")
        }
        XCTAssertEqual(message, "Ошибка HTTP 404.")
    }

    func testStateIsAlwaysSingle() {
        var state: ViewState<[Int]> = .loading

        state = .failed("Ошибка соединения.")

        XCTAssertEqual(state, .failed("Ошибка соединения."))
        XCTAssertNotEqual(state, .loading)
    }
}
