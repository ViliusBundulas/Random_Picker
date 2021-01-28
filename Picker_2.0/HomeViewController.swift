//
//  ViewController.swift
//  Picker_2.0
//
//  Created by Vilius Bundulas on 2021-01-23.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var progressBar: ProgressBar!
    @IBOutlet var studentLabel: UILabel!
    @IBOutlet var studentsTableView: UITableView!
    
    //MARK:- Button implementation
    
    @IBOutlet var pickGroupButton: UIButton! {
        didSet {
            pickGroupButton.layer.cornerRadius = 25.0
            pickGroupButton.layer.masksToBounds = true
            pickGroupButton.layer.backgroundColor = CGColor(red: 73.0/255, green: 159.0/255.0, blue: 213.0/255.0, alpha: 1)
        }
    }
    
    @IBAction func pickGroupButtonPressed(_ sender: UIButton) {
        switch students.isEmpty {
        case false:
            progressBar.progress += 1
            studentLabel.isHidden = false
            addStudentToTheStage()
            pickGroupButton.setTitle("KITAS", for: .normal)
        case true:
            progressBar.progress = 0
            studentLabel.isHidden = true
            pickGroupButton.setTitle("IŠ NAUJO", for: .normal)
            students += studentsOtherArray
            studentsOtherArray.removeAll()
        }
        print("\(progressBar.progress)")
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        progressBar.progress = 0
        guard let savedStudents = UserDefaultsManager.students else { return }
        students = savedStudents
        studentsOtherArray.removeAll()
        progressBar.numberOfStudents = students.count
        studentsTableView.reloadData()
    }
    
    
    //MARK:- Students list
    
    var students: [Student] = [
        Student(name: "Nerijus", surname: "Šurkys"),
        Student(name: "Lech", surname: "Lipnicki"),
        Student(name: "Monika", surname: "Zdanevičiūtė"),
        Student(name: "Vilius", surname: "Bundulas"),
        Student(name: "Remigijus", surname: "Klimovas"),
        Student(name: "Arvydas", surname: "Klimavičius"),
        Student(name: "Lukas Uscila", surname: "Dainavičius"),
        Student(name: "Arvydas", surname: "Mickus"),
        Student(name: "Lukas", surname: "Adomavičius"),
        Student(name: "Kristijonas", surname: "Plukas"),
        Student(name: "Petras", surname: "Janulevičius"),
        Student(name: "Anton", surname: "Jemanov")
    ] {
        didSet {
            studentsTableView.reloadData()
        }
    }
    
    var studentsOtherArray: [Student] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentsTableView.delegate = self
        studentsTableView.dataSource = self
    }
    
    
    
//MARK:- Alerts
    
    private func showAlert()  {
        let alert = UIAlertController(
            title: "Dėmesio!",
            message: "Paskaitoje ne visi studentai, nepamirškite pradėti įrašymo.",
            preferredStyle: .alert
        )
        let alertButton = UIAlertAction(
            title: "Gerai",
            style: .cancel
        ) { action in
            self.progressBar.numberOfStudents = self.students.count + self.studentsOtherArray.count
        }
        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
}
//MARK:- Table view implementation

extension HomeViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = "Studentai"
        
        return header.uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListCell", for: indexPath)
        let studentRow = students[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1).) " + studentRow.name + " " + studentRow.surname
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
//            studentsOtherArray.append(students[index])
            students.remove(at: index)
            studentsTableView.reloadData()
            students.count < 12 ? showAlert() : nil
//            studentsTableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            return
            //        } else if editingStyle == .insert {
            //            students.append(Student(name: String, surname: String))
        }
    }
    
    //MARK:- pick student
    
    func addStudentToTheStage() {
        if !students.isEmpty {
            students.shuffle()
            let randomStudent = students.first
            studentLabel.text = randomStudent!.name + " " + randomStudent!.surname
            studentsOtherArray.append(randomStudent!)
            students.removeFirst()
        } else {
            return
        }
        
    }
}


