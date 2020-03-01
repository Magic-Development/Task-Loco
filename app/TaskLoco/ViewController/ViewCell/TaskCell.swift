//
//  TaskCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit


class TaskCell: UICollectionViewCell {
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskPriority: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskCompleteDate: UILabel!
    @IBOutlet weak var taskResponsible: UILabel!
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
    
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	func updateTask(task: Task) {
		taskName.text = task.title
		taskPriority.text = task.priority.rawValue
		taskDescription.text = task.description
		taskCompleteDate.text = task.dateAsString()
		taskResponsible.text = task.responsible
	}
}
