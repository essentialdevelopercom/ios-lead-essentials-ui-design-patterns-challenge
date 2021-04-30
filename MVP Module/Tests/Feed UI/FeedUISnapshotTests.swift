//
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import XCTest
import FeedFeature
@testable import MVP

class FeedUISnapshotTests: XCTestCase {
	//  ***********************
	//
	//  Uncomment and run one test at a time
	//  to validate the layout (including Dark Mode support).
	//
	//  ***********************

	func test_emptyFeed() {
		let sut = makeSUT()

		sut.display(emptyFeed())

		assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "EMPTY_FEED_light")
		assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "EMPTY_FEED_dark")
	}

//	func test_feedWithError() {
//		let sut = makeSUT()
//
//		sut.display(errorMessage: "An error message")
//
//		assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "FEED_WITH_ERROR_light")
//		assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "FEED_WITH_ERROR_dark")
//	}

	// MARK: - Helpers

	private func makeSUT() -> FeedViewController {
		let bundle = Bundle(for: FeedViewController.self)
		let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
		let controller = storyboard.instantiateInitialViewController() as! FeedViewController
		controller.loadViewIfNeeded()
		controller.tableView.showsVerticalScrollIndicator = false
		controller.tableView.showsHorizontalScrollIndicator = false
		return controller
	}

	private func emptyFeed() -> [FeedImageCellController] {
		[]
	}
}

private extension FeedViewController {
	func display(errorMessage: String) {
		fatalError("Must be implemented - follow the MVC solution as a guide")
	}
}
