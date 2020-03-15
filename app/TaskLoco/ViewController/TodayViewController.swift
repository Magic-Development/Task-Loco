//
//  TodayViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift
import UICircularProgressRing

class TodayViewController: UIViewController, UITableViewDataSource {
	
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var todayTableView: UITableView!
    @IBOutlet weak var remainingText: UILabel!
    
	private var progressBar: UICircularProgressRing?
	private var todayData: [Task] = []
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		todayTableView.dataSource = self
		self.progressBar = addProgressBar(headerView)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.getTodayTasks(username: TL.authManager.provideUsername())
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { tasks in
				self.handleResponse(tasks: tasks)
			}, onError: { error in
				self.handleError(error)
			})
		.disposed(by: disposeBag)
	}
	
	private func handleResponse(tasks: [Task]) {
		let completed = tasks.filter { $0.status == .completed }
		remainingText.text = "\(tasks.count - completed.count) out of \(tasks.count) remaining"
		updateProgressBar(value: CGFloat(completed.count) / CGFloat(tasks.count))
		self.todayData = tasks
		self.todayTableView.reloadData()
	}
	
	private func updateProgressBar(value: CGFloat) {
		progressBar?.startProgress(to: (value*100), duration: 2.0)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.todayData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.today, for: indexPath) as! TaskCell
		cell.updateView(self.todayData[indexPath.row])
		return cell
	}
}
