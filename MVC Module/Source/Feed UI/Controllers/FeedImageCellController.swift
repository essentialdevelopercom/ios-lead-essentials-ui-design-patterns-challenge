//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

final class FeedImageCellController {
	private let model: FeedImage
	private let imageLoader: FeedImageDataLoader

	private var task: FeedImageDataLoaderTask?
	private var cell: FeedImageCell?

	init(model: FeedImage, imageLoader: FeedImageDataLoader) {
		self.model = model
		self.imageLoader = imageLoader
	}

	func view(in tableView: UITableView) -> UITableViewCell {
		cell = tableView.dequeueReusableCell()
		cell?.locationContainer.isHidden = (model.location == nil)
		cell?.locationLabel.text = model.location
		cell?.descriptionLabel.text = model.description
		cell?.feedImageView.image = nil
		cell?.feedImageRetryButton.isHidden = true
		cell?.feedImageContainer.isShimmering = true
		cell?.onRetry = { [weak self] in self?.loadImage() }
		loadImage()
		return cell!
	}

	func preload() {
		loadImage()
	}

	func cancelLoad() {
		releaseCellForReuse()
		task?.cancel()
	}

	private func loadImage() {
		task = imageLoader.loadImageData(from: model.url) { [weak self] result in
			let data = try? result.get()
			let image = data.map(UIImage.init) ?? nil
			self?.cell?.feedImageView.setImageAnimated(image)
			self?.cell?.feedImageRetryButton.isHidden = (image != nil)
			self?.cell?.feedImageContainer.isShimmering = false
		}
	}

	private func releaseCellForReuse() {
		cell = nil
	}
}
