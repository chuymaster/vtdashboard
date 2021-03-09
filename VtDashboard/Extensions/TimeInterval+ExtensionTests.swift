import VtDashboard
import XCTest

final class TimeIntervalExtensionTests: XCTest {
    func testDisplayText() {
        let timeInterval: TimeInterval = 1615160142636
        XCTAssertEqual(timeInterval.displayText, "2021-03-08 08:35")
    }
}
