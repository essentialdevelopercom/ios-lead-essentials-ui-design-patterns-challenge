//
//  FeedRefreshViewController.swift
//  MVVM
//
//  Created by Alex Thurston on 6/16/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit
import FeedFeature

final class FeedRefreshViewController: NSObject {
	@IBOutlet var view: UIRefreshControl?
	@IBOutlet var errorView: ErrorView?

	@IBAction func refresh() {
		
	}
}
