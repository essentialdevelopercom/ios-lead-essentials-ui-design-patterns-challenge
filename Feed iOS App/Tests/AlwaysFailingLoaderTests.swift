//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import XCTest
import FeedFeature
import FeediOSApp

final class AlwaysFailingLoaderTests: XCTestCase {
	func test_loadFeed_alwaysFails() {
		let sut = AlwaysFailingLoader(delay: 0)
		let exp = expectation(description: "Wait for load completion")

		sut.load { result in
			switch result {
			case .success: XCTFail("Expected failure, got \(result) instead")
			default: break
			}

			exp.fulfill()
		}

		wait(for: [exp], timeout: 1.0)
	}

	func test_loadFeedImage_alwaysFails() {
		let sut = AlwaysFailingLoader(delay: 0)
		let exp = expectation(description: "Wait for load completion")
		let url = URL(string: "http://any-url.com")!

		_ = sut.loadImageData(from: url) { result in
			switch result {
			case .success: XCTFail("Expected failure, got \(result) instead")
			default: break
			}

			exp.fulfill()
		}

		wait(for: [exp], timeout: 1.0)
	}
}
