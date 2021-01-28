//
//  Students.swift
//  Picker_2.0
//
//  Created by Vilius Bundulas on 2021-01-24.
//

import Foundation

class Student: Codable {
    var name: String
    var surname: String
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
}
