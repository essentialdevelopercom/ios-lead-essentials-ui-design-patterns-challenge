//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

struct FeedErrorViewModel {
	let errorMessage:String
}

protocol FeedErrorView {
	func display(_ viewModel: FeedErrorViewModel)
}

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let feedErrorView: FeedErrorView
	
	init(feedView: FeedView, loadingView: FeedLoadingView, feedErrorView: FeedErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.feedErrorView = feedErrorView
	}
	
	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		feedErrorView.display(FeedErrorViewModel(errorMessage: "A feed error"))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
