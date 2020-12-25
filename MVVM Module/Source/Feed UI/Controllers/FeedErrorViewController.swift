//
//  FeedErrorViewController.swift
//  MVVM
//
//  Created by Mario Alberto Barragán Espinosa on 25/12/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import UIKit

final class FeedErrorViewController: NSObject {
	@IBOutlet var errorView: ErrorView?
	
	var viewModel: FeedViewModel? {
		didSet {
			bind()
		}
	}
	
	func hideError() {
		errorView?.hideMessage()
	}
	
	private func bind() {		
		viewModel?.onFeedLoadError = { [weak self] errorMessage in 
            self?.errorView?.show(message: errorMessage)
		}		
	}
}
