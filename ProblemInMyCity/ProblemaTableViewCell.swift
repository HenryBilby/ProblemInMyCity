//
//  ProblemaTableViewCell.swift
//  ProblemInMyCity
//
//  Created by Henry Bilby on 09/01/22.
//

import UIKit

class ProblemaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewProblema : UIImageView!
    @IBOutlet weak var labelNome : UILabel!
    @IBOutlet weak var labelEndereco : UILabel!
    
    func setup(problem : Problem) {
        labelNome.text = problem.nome
        labelEndereco.text = problem.endereco
        if let foto = problem.foto {
            imageViewProblema.image = UIImage(data: foto)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
