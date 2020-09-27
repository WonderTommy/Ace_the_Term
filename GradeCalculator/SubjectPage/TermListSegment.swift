//
//  TermListSegment.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-27.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class TermListSegment: UITableView {
    private static let cellIdentifier = "CellListCell"
    private var viewModel: GeneralViewModel
    private var terms: Array<Term> {
        get {
            return viewModel.getTerms()
        }
    }
    init(frame: CGRect, style: UITableView.Style, viewModel: GeneralViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configCell() {
        self.delegate = self
        self.dataSource = self
        //set row height
        self.rowHeight = 48
        //register cells
        self.register(TermListCell.self, forCellReuseIdentifier: TermListSegment.cellIdentifier)
        //set constraints
    //        tableView.free()
        self.allowsMultipleSelectionDuringEditing = true
    }
}


extension TermListSegment: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTerms().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TermListSegment.cellIdentifier) as! TermListCell
        let term = terms[indexPath.row]
        cell.setTerm(term: term)
        print(term.title)
        return cell
    }
    
    
}
