//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

protocol FeedErrorView {
	func display(_ errorModel: FeedErrorModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let errorView: FeedErrorView
	
	init(feedView: FeedView, loadingView: FeedLoadingView, errorView: FeedErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.errorView = errorView
	}
	
	func didStartLoadingFeed() {
		errorView.display(FeedErrorModel(errorText: .none))
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		let errorText = "FEED_VIEW_CONNECTION_ERROR".localizedString()
		errorView.display(FeedErrorModel(errorText: errorText))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}


private extension String {
	func localizedString() -> String {
		let bundle = Bundle(for: FeedViewController.self)
		let localizedString = bundle.localizedString(forKey: self, value: nil, table: "Feed")
		return localizedString
	}
}
