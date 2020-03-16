//
//  Constants.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import DynamicColor

enum ViewController {
	static var login = "LoginViewController"
	static var signUp = "SignupViewController"
	static var tabBar = "TabBarViewController"
	static var today = "TodayViewController"
}

enum CellConstants {
	static var today = "TodayCell"
	static var task = "TaskPrototypeCell"
}

enum ColorConstants{
	static var primaryColorAlpha = UIColor(red:0.00, green:0.33, blue:0.58, alpha:0.8)
	static var primaryColor = UIColor(red:0.00, green:0.33, blue:0.58, alpha:1)
	static var lightBlue = DynamicColor(hexString: "#0096FF")
	static var lightYellow = DynamicColor(hexString: "#FFD479")
	static var lightGreen = DynamicColor(hexString: "#009193")
}

enum Alerts{
	static var dismiss = "Dismiss"
	static var invalidInput = "Invalid Input"
	static var inputRequired = "All Input is Required"
}

enum ErrorConstants {
	static let defaultErrorTitle = "Error Occured"
	static let defaultErrorMessage = "Unknown Reasons"
	
	static func defaultError() -> ResponseError {
		return ResponseError(name: defaultErrorTitle, message: defaultErrorTitle)
	}
	
	static func defaultError(_ message: String) -> ResponseError {
		return ResponseError(name: defaultErrorTitle, message: message)
	}
}

enum DateFormat {
	static var monthDateCommaYear = "MMM dd,yyyy"
	static var monthDateYearDash = "MM/dd/yyyy"
}

enum LayerConstants {
	static var pulse = "pulse"
}
