import Combine
import Foundation
import XCTest

@testable import VtDashboard

class ChannelRequestsViewModelTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()

    func testInitialization() {
        let viewModel = ChannelRequestsViewModel()
        XCTAssertFalse(viewModel.isBusy)
    }
    
    func testGetChannelRequests() {
        let expectation = expectation(description: "channelRequests are retrieved.")
        let mockNetworkClient = MockNetworkClient()
        let viewModel = ChannelRequestsViewModel(networkClient: mockNetworkClient)
        
        var statuses: [ViewStatus] = []
        viewModel.$viewStatus
            .sink { status in
                statuses.append(status)
            }.store(in: &cancellables)
        
        viewModel.$channelRequests
            .dropFirst()
            .sink { _ in
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        viewModel.getChannelRequests()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(statuses, [.loading, .loaded])
        XCTAssertEqual(
            viewModel.channelRequests.map { $0.channelId },
            [
                "UCicCFumqJgPj23vkAh_1TbA",
                "UC6Q4UI5mEjeZOIRoTtRoFJA"
            ]
        )
    }
}
