//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

public final class FeedUIComposer {
	private init() {}
	
	public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
		let feedViewModel = FeedViewModel()
		let feedController = FeedViewController.makeWith(
			viewModel: feedViewModel)
        
        let refreshViewModel = FeedRefreshViewModel(feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))
        feedController.refreshController.viewModel = refreshViewModel
        
        feedController.refreshController.viewModel?.onFeedLoad = adaptFeedToCellControllers(
			forwardingTo: feedController,
			imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader))

		return feedController
	}
	
	private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, imageLoader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
		return { [weak controller] feed in
			controller?.tableModel = feed.map { model in
				FeedImageCellController(viewModel:
					FeedImageViewModel(model: model, imageLoader: imageLoader, imageTransformer: UIImage.init))
			}
		}
	}
}

private extension FeedViewController {
	static func makeWith(viewModel: FeedViewModel) -> FeedViewController {
		let bundle = Bundle(for: FeedViewController.self)
		let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
		let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
		feedController.viewModel = viewModel
		return feedController
	}
}
