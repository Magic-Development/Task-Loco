//
//  CreateProject.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 5/3/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class CreateProjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, OnSelectionDelegate {
	
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var projectId: UITextField!
    @IBOutlet weak var projectDescription: UITextField!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet weak var buttonBackground: RandientView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    
	private let ADD_INDEX = 0
	private let PROJECT_ID = "-\(Int.random(in: 100..<999))"
	var team: [UserHeader] = []
	private let diposeBag = DisposeBag()
    
    override func viewDidLoad() {
		super.viewDidLoad()
		initView()
		initCollectionView()
	}
	
	private func initView() {
		let gradient = self.buttonBackground.randomize(animated: true)
        self.buttonLabel.handleColor(gradient: gradient)
		self.name.bottomBorder(uiColor: ColorConstants.lightGrey)
        self.projectId.bottomBorder(uiColor: ColorConstants.lightGrey)
        self.projectDescription.bottomBorder(uiColor: ColorConstants.lightGrey)
		self.name.addTarget(self, action: #selector(CreateProjectViewController.onChange(_:)), for: .editingChanged)
	}
	
	@objc func onChange(_ textField: UITextField) {
		if(textField.text?.count ?? 0 < 5) {
			if(textField.text?.count ?? 0 == 0) {
				self.projectId.text = General.empty
			} else {
				self.projectId.text = (textField.text?.uppercased() ?? General.empty) + PROJECT_ID
			}
		}
	}
	
    @IBAction func createProject(_ sender: Any) {
		if(self.team.isEmpty) {
			messageAlert(Alerts.invalidInput, Alerts.atleastOneMember)
		} else if(self.name.text?.isEmpty == true || self.projectDescription.text?.isEmpty == true) {
			messageAlert(Alerts.invalidInput, Alerts.inputRequired)
		} else {
			TL.taskLocoApi.createProject(project: createProject())
				.mapToHandleResponse()
				.observeOn(MainScheduler.instance)
				.subscribe(onNext: { project in
					self.dismissAlertController()
				}, onError: { error in
					self.handleError(error)
				}).disposed(by: diposeBag)
		}
    }
	
	func createProject() -> Project{
		return Project(name: self.name.text ?? General.empty,
				projectId: self.projectId.text ?? General.empty,
				description: self.projectDescription.text ?? General.empty,
				users: team, starred: false, autoClose: true)
	}
    
    private func initCollectionView() {
		self.teamCollectionView.dataSource = self
		self.teamCollectionView.delegate = self
		let width = (view.frame.size.width - 42) / 2
		let layout = self.teamCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.team.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if(indexPath.row == ADD_INDEX) {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.add, for: indexPath) as! AddUserCell
			cell.updateCell()
			cell.applyBorder()
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.user, for: indexPath) as! UserCell
			cell.updateCell(self.team[indexPath.row - 1])
			cell.applyBorder()
			return cell
		}
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if(indexPath.row == ADD_INDEX) {
			self.navigateToUsersAlertSheet(.multiple, self, team)
		} else {
			self.removeAlert(team[indexPath.row - 1], remove: { (action) in
				self.team.remove(at: indexPath.row - 1)
			})
		}
	}
	
	func onSelected(selection: [UserHeader]) {
		self.team.append(contentsOf: selection)
		self.teamCollectionView.reloadData()
	}
}