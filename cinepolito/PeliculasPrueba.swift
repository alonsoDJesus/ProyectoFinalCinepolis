//
//  PeliculasPrueba.swift
//  cinepolito
//
//  Created by IMAC17 on 04/05/23.
//

import UIKit

class PeliculasPrueba: UICollectionViewCell {
    
    
    @IBOutlet weak var duracion: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var genero: UILabel!
    @IBOutlet weak var clasificacion: UIButton!
    @IBOutlet weak var idioma: UILabel!
    @IBOutlet weak var horarios: UILabel!
    
    @IBOutlet weak var titulo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
