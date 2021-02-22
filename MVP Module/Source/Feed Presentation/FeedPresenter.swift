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

struct FeedErrorViewModel {
	let message: String?
}

protocol FeedErrorView {
	func display(_ viewModel: FeedErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let errorView: FeedErrorView
	private let loadingView: FeedLoadingView
	
	init(feedView: FeedView, errorView: FeedErrorView, loadingView: FeedLoadingView) {
		self.feedView = feedView
		self.errorView = errorView
		self.loadingView = loadingView
	}
	
	func didStartLoadingFeed() {
		errorView.display(FeedErrorViewModel(message: nil))
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		errorView.display(FeedErrorViewModel(message: "Error"))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
