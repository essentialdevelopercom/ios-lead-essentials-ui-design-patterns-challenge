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
	private let loadingView: FeedLoadingView
    private let feedErrorView: FeedErrorView
    
    var errorMessage = Localized.Feed.loadError
	
	init(feedView: FeedView, loadingView: FeedLoadingView, feedErrorView: FeedErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
        self.feedErrorView = feedErrorView
	}
    
	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
        feedErrorView.display(FeedErrorViewModel(message: nil))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
        feedErrorView.display(FeedErrorViewModel(message: nil))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
        feedErrorView.display(FeedErrorViewModel(message: errorMessage))
	}
}
