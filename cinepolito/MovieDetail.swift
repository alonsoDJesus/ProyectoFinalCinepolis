//
//  MovieDetail.swift
//  cinepolito
//
//  Created by IMAC18 on 09/05/23.
//

import UIKit

class MovieDetail: UIViewController {
    
    var m: Movie?
    var pelicula: Dictionary<String, String>?
    var horas: [String]?
    
    @IBOutlet weak var sinopsis: UITextView!
    @IBOutlet weak var movieTitle: UITextView!
    @IBOutlet weak var hero: UIImageView!
    @IBOutlet weak var sinopsisView: UIView!
    @IBOutlet weak var clasificacion: UIButton!
    @IBOutlet weak var genero: UILabel!
    @IBOutlet weak var duracion: UILabel!
    @IBOutlet weak var horarios: UICollectionView!
    
    @IBOutlet weak var viewHorarios: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: pelicula!["img_horizontal"]!)
        hero.kf.setImage(with: url)
        hero.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        
        movieTitle.text = pelicula!["titulo"]!
        sinopsis.text = pelicula!["sinopsis"]!
        clasificacion.setTitle(pelicula!["clasificacion"]!, for: UIControl.State.normal)
        genero.text = pelicula!["genero"]!
        duracion.text = pelicula!["duracion"]!
        
        sinopsisView.layer.cornerRadius = 10
        
        horas = pelicula!["horarios"]!.components(separatedBy: " ")
        
        horarios.dataSource = self
        horarios.delegate = self
        
        horarios.register(UINib(nibName: "Horarios", bundle: nil), forCellWithReuseIdentifier: "horario")
        
        viewHorarios.layer.cornerRadius = 10
        
    }
    

}

extension MovieDetail: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return horas!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = horarios.dequeueReusableCell(withReuseIdentifier: "horario", for: indexPath) as? Horarios
        
        
        
        cell?.btn_hora.setTitle(horas![indexPath.row], for: UIControl.State.normal)
        
        print(horas![indexPath.row])
        
        return cell!
    }
    
}

extension MovieDetail: UICollectionViewDelegate {

}
