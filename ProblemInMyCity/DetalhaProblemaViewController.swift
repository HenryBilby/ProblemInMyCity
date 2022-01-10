//
//  DetalheViewController.swift
//  ProblemInMyCity
//
//  Created by Henry Bilby on 09/01/22.
//

import UIKit

class DetalhaProblemaViewController  : UIViewController {
    
    var problem : Problem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exibeProblema()
    }
    
    private func exibeProblema() {
        guard let problem = self.problem else {return}
        print(problem.nome ?? "")
    }
}
