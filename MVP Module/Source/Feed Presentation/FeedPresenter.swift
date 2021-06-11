//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedLoadingErrorDisplayingView {
	func display(errorMessage: String)
	func hideError()
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let loadingErrorDisplayingView: FeedLoadingErrorDisplayingView
	
	init(feedView: FeedView, loadingView: FeedLoadingView, loadingErrorDisplayingView: FeedLoadingErrorDisplayingView) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.loadingErrorDisplayingView = loadingErrorDisplayingView
	}

	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
		loadingErrorDisplayingView.hideError()
	}

	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}

	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
		loadingErrorDisplayingView.display(errorMessage: Localized.Feed.loadError)
	}
}
