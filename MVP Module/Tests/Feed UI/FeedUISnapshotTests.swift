//
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import XCTest
import FeedFeature
@testable import MVP

class FeedUISnapshotTests: XCTestCase {

    func test_emptyFeed() {
        let sut = makeSUT()

        sut.display(emptyFeed())

        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "EMPTY_FEED_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "EMPTY_FEED_dark")
    }

    func test_feedWithError() {
		let sut = makeSUT()

        sut.display(errorMessage: "An error message")

		assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "FEED_WITH_ERROR_light")
		assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "FEED_WITH_ERROR_dark")
    }
	
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

private class FeedLoaderStub: FeedLoader, FeedImageDataLoader, FeedImageDataLoaderTask {
    private let result: FeedLoader.Result
    
    init(_ result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }
    
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return self
    }
    
    func cancel() { }
}

private extension FeedViewController {
    func display(errorMessage: String) {
        let loader = FeedLoaderStub(.failure(NSError(domain: "any", code: 0)))
        let adapter = FeedLoaderPresentationAdapter(feedLoader: loader)
        let presenter = FeedPresenter(
            feedView: FeedViewAdapter(
                controller: self,
                imageLoader: loader
            ),
            loadingView: self,
            feedErrorView: self
        )
        adapter.presenter = presenter
        presenter.errorMessage = errorMessage
        delegate = adapter
        simulateUserInitiatedFeedReload()
    }
}
