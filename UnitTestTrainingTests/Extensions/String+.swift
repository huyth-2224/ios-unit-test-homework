//
//  String+.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/27/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

import UIKit

extension String {
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
    
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        let date = dateFormatter.date(from: self)!
        return date
    }
}
