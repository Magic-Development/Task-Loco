//
//  TaskLocoProvider.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/1/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class TL {
	
	public static var preferences = UserDefaults.standard
	
	private static var networkInterceptor = NetworkInterceptor(authManager: userManager)
	
	public static var session = Session(interceptor: networkInterceptor)
	
	public static var taskLocoApi: TaskLocoApi = TaskLocoApiManager()

	public static var userManager = UserManger(preferences: preferences, taskLocoApi: taskLocoApi)
	
	public static var datePicker = UIDatePicker()
}
