//
//  MultiSelectAndMoveTableViewController.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-17.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

open class MultiSelectAndMoveTableViewController: UITableViewController {
    
//    private var dataLength: Int
    lazy var selectedIndex: [Bool] = {
        var temp: [Bool] = []
        for _ in 0..<getDataLength() {
            temp.append(false)
        }
        return temp
    }()
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // this method must be overridded
    func getDataLength() -> Int {
        fatalError("\(String(describing: MultiSelectAndMoveTableViewController.self))::\(#function) not impelemnted")
    }
    
    // to take advantage of this class, this method must be called as super in the sub-class
    open override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if !isEditing {
//            selectedIndex.removeAll(keepingCapacity: true)
            for index in 0..<selectedIndex.count {
                selectedIndex[index] = false
            }
        } else {
            if selectedIndex.count < getDataLength() {
                let difference = getDataLength() - selectedIndex.count
                for _ in 0..<difference {
                    selectedIndex.append(false)
                }
            }
        }
    }
    
    // to take advantage of this class, this method must be called as super in the sub-class
    // call the super at the end of the overriding method
    @objc func deleteButtonSelector() {
            print("transh button clicked")
            print(selectedIndex)
    //        selectedIndex.removeAll(keepingCapacity: true)

            let originLength = selectedIndex.count
            for rawIndex in 0..<originLength {
                let index = originLength - 1 - rawIndex
                if selectedIndex[index] == true {
                    selectedIndex.remove(at: index)
                }
            }
        }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self.selectedIndex.count)")
    }
    
    // to take advantage of this class, this method must be called as super in the sub-class
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select: ", indexPath.row)
        if (tableView.isEditing) {
//            if (!selectedIndex.contains(indexPath.row)) {
//                selectedIndex.append(indexPath.row)
//            }
            selectedIndex[indexPath.row] = true
            print(selectedIndex)
        }
    }
    
    // to take advantage of this class, this method must be called as super in the sub-class
    open override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("delect: \(indexPath.row)")
//        selectedIndex.removeAll(where: { $0 == indexPath.row })
        selectedIndex[indexPath.row] = false
        print(selectedIndex)
    }
    
    // to take advantage of this class, this method must be called as super in the sub-class
    open override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempSource = selectedIndex[sourceIndexPath.row]
        selectedIndex.remove(at: sourceIndexPath.row)
        selectedIndex.insert(tempSource, at: destinationIndexPath.row)
        
        print(selectedIndex)
    }

}
