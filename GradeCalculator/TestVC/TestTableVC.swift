//
//  TestTableVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-08.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class TestTableVC: UITableViewController {
    
    let firstNameCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    let lastNameCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    let feedBackCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Feedback"
        cell.accessoryType = .disclosureIndicator
        return cell
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "User Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        view.addSubview(firstNameCell)
//        view.addSubview(lastNameCell)
//        view.addSubview(feedBackCell)
        
        setUpLayout()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setUpLayout() {
        firstNameCell.addSubview(firstNameTextField)
        firstNameTextField.leadingAnchor.constraint(equalTo: firstNameCell.leadingAnchor, constant: 20).isActive = true
        firstNameTextField.centerYAnchor.constraint(equalTo: firstNameCell.centerYAnchor).isActive = true
        
        lastNameCell.addSubview(lastNameTextField)
        lastNameTextField.leadingAnchor.constraint(equalTo: lastNameCell.leadingAnchor, constant: 20).isActive = true
        lastNameTextField.centerYAnchor.constraint(equalTo: lastNameCell.centerYAnchor).isActive = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            fatalError()
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return firstNameCell
            case 1:
                return lastNameCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return feedBackCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Profile"
        case 1:
            return "Contact"
        default:
            fatalError()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
