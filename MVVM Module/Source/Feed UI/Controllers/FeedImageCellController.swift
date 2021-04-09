//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

final class FeedImageCellController {
	private let viewModel: FeedImageViewModel<UIImage>
	private var cell: FeedImageCell?

	init(viewModel: FeedImageViewModel<UIImage>) {
		self.viewModel = viewModel
	}

	func view(in tableView: UITableView) -> UITableViewCell {
		let cell = binded(tableView.dequeueReusableCell())
		viewModel.loadImageData()
		return cell
	}

	func preload() {
		viewModel.loadImageData()
	}

	func cancelLoad() {
		releaseCellForReuse()
		viewModel.cancelImageDataLoad()
	}

	private func binded(_ cell: FeedImageCell) -> FeedImageCell {
		self.cell = cell

		cell.locationContainer.isHidden = !viewModel.hasLocation
		cell.locationLabel.text = viewModel.location
		cell.descriptionLabel.text = viewModel.description
		cell.onRetry = viewModel.loadImageData

		viewModel.onImageLoad = { [weak self] image in
			self?.cell?.feedImageView.setImageAnimated(image)
		}

		viewModel.onImageLoadingStateChange = { [weak self] isLoading in
			self?.cell?.feedImageContainer.isShimmering = isLoading
		}

		viewModel.onShouldRetryImageLoadStateChange = { [weak self] shouldRetry in
			self?.cell?.feedImageRetryButton.isHidden = !shouldRetry
		}

		return cell
	}

	private func releaseCellForReuse() {
		cell = nil
	}
}
