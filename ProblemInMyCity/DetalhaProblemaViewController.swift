//
//  DetalheViewController.swift
//  ProblemInMyCity
//
//  Created by Henry Bilby on 09/01/22.
//

import UIKit

class DetalhaProblemaViewController  : UIViewController {
    
    var problem : Problem!
    
    @IBOutlet weak var imageViewFoto: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelEndereco: UILabel!
    @IBOutlet weak var textViewDescricao: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exibeProblema()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CriaProblemaViewController,
           let problem = problem,
           segue.identifier == "vaiParaEdicao" {
                controller.problem = problem
        }
    }
    
    @IBAction func buttonEditar(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "vaiParaEdicao", sender: nil)
    }
    
    private func exibeProblema() {
        guard let problem = self.problem else {return}
        
        if let image = problem.foto {
            imageViewFoto.image = UIImage(data: image)
        }
        
        labelNome.text = problem.nome
        labelEndereco.text = problem.endereco
        textViewDescricao.text = problem.descricao
    }
}
