//
//  ViewController.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-30.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let nextButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNextButton()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }

    func setNextButton() {
        self.nextButton.backgroundColor = .white
        self.nextButton.setTitleColor(.red, for: .normal)
        self.nextButton.setTitle("NEXT", for: .normal)
        self.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(self.nextButton)
        
        setNextButtonConstraints()
    }
    
    @objc func nextButtonTapped() {
        let nextScreen = SecondViewController()
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    func setNextButtonConstraints() {
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

