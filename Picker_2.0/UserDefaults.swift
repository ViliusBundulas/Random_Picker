//
//  UserDefaults.swift
//  Picker_2.0
//
//  Created by Vilius Bundulas on 2021-01-28.
//

import Foundation

struct UserDefaultsManager {
    
    private enum UserDefaultsManagerKey {
        static let students = "Students"
    }
    
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    static var students: [Student]? {
        get {
            guard let encodedStudents = userDefaults.object(forKey: UserDefaultsManagerKey.students) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode([Student].self, from: encodedStudents)
        } set {
            let encodedStudents = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedStudents, forKey: UserDefaultsManagerKey.students)
        }
    }
}
