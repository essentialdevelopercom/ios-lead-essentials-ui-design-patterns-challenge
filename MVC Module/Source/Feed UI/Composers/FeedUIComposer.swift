//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

public final class FeedUIComposer {
	private init() {}

	public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
		let feedController = FeedViewController.make()
		feedController.refreshController?.feedLoader = MainQueueDispatchDecorator(decoratee: feedLoader)
		feedController.refreshController?.onRefresh = adaptFeedToCellControllers(
			forwardingTo: feedController,
			imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader))
		return feedController
	}

	private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, imageLoader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
		return { [weak controller] feed in
			controller?.tableModel = feed.map { model in
				FeedImageCellController(model: model, imageLoader: imageLoader)
			}
		}
	}
}

private extension FeedViewController {
	static func make() -> FeedViewController {
		let bundle = Bundle(for: FeedViewController.self)
		let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
		let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
		feedController.title = Localized.Feed.title
		return feedController
	}
}
