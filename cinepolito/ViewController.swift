//
//  ViewController.swift
//  cinepolito
//
//  Created by IMAC17 on 24/04/23.
//

import UIKit
import Foundation //para calculara el tamaño de la pantalla
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewController: UIViewController {

    //let images: [String] = ["increibles","deadpool","at-man"]
    var movies: [Movie]?
    var miWidthScreen = UIScreen.main.bounds.width
    var i = 0
    var iActual = 0
    var movieSeleccionada : Int?
    
    var timer = Timer()
    let db = Firestore.firestore()
    var allMovies : [QueryDocumentSnapshot]?
    var allMoviesData : [Dictionary <String, Any>]?
    

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var ubicacion: UIView!
    @IBOutlet weak var btnAll: UIButton!
    
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    @IBOutlet weak var CollectionView2: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        CollectionView2.isHidden=true
        activityIndicator.startAnimating()
        
        
        //CollectionView2.isHidden=true
        //activityIndicator.startAnimating()
        self.db.collection("Peliculas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.activityIndicator.stopAnimating()
                self.CollectionView2.isHidden=false
            } else {
                
                self.allMovies = querySnapshot!.documents
                
                self.activityIndicator.stopAnimating()
                self.CollectionView2.isHidden=false
                
                self.MyCollectionView.dataSource = self
                self.MyCollectionView.delegate = self
                
                self.CollectionView2.dataSource = self
                self.CollectionView2.delegate = self

                
                self.MyCollectionView.register(UINib(nibName: "MyCustom", bundle: nil), forCellWithReuseIdentifier: "myCelda")
                self.CollectionView2.register(UINib(nibName: "PeliculasPrueba", bundle: nil), forCellWithReuseIdentifier: "nuevaCelda")
                self.timer = Timer.scheduledTimer(timeInterval: 1.0,//cada cuando se va a ejecutar
                                                  target: self, selector: #selector(self.timeAction), userInfo: nil, repeats: true)
                
                self.ubicacion.layer.cornerRadius = 20
                
            }
        }
        
        
    }
    
    func comprueba(){
        print(allMovies as Any)
    }
    
    @objc func timeAction(){
        iActual = MyCollectionView.indexPathsForVisibleItems[0].row+1
       
        if iActual >= allMovies!.count{
            iActual = 0;
            
        }
                
        MyCollectionView.scrollToItem(at: IndexPath(item: iActual, section: 0), at: .right, animated: true)
         
    }
    
    @IBAction func btnGet(_ sender: Any) {
       
        print(movies!)
        
    }
    
    func verDetallePelicula(i: Int){
        movieSeleccionada = i
        performSegue(withIdentifier: "toMovieDetail", sender: self)
        
    }
    
    // Este mètodo se ejecuta antes que el metodo editarContacto
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetail"{
            if let destino = segue.destination as? MovieDetail{
                //destino.m = movies![movieSeleccionada!]
                
                destino.pelicula = [
                    "titulo": (allMovies![movieSeleccionada!].data()["titulo"] as! String),
                    "sinopsis": (allMovies![movieSeleccionada!].data()["sinopsis"] as! String),
                    "img_horizontal": (allMovies![movieSeleccionada!].data()["url_carrusel"] as! String),
                    "clasificacion": (allMovies![movieSeleccionada!].data()["clasificacion"] as! String),
                    "genero": (allMovies![movieSeleccionada!].data()["genero"] as! String),
                    "duracion": (allMovies![movieSeleccionada!].data()["duracion"] as! String),
                    "horarios": (allMovies![movieSeleccionada!].data()["horarios"] as! String),
                        
                ]
            }
        }
    }
    
}
extension ViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == CollectionView2){
            return allMovies!.count
        }
        return allMovies!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//dibuja las celdas
        
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "myCelda", for: indexPath) as? MyCustom
        

        
        if (collectionView == CollectionView2){
            let cell2 = CollectionView2.dequeueReusableCell(withReuseIdentifier: "nuevaCelda", for: indexPath) as! PeliculasPrueba
            //cell2.img.image = UIImage(named: images[indexPath.row])
            cell2.titulo.text = (allMovies![indexPath.row].data()["titulo"] as! String)
            cell2.genero.text = (allMovies![indexPath.row].data()["genero"] as! String)
            cell2.idioma.text = (allMovies![indexPath.row].data()["idioma"] as! String)
            cell2.horarios.text = (allMovies![indexPath.row].data()["horarios"] as! String)
            cell2.clasificacion.setTitle((allMovies![indexPath.row].data()["clasificacion"] as! String), for: UIControl.State.normal)
            cell2.duracion.text = (allMovies![indexPath.row].data()["duracion"] as! String)
            
            
            let url = URL(string: allMovies![indexPath.row].data()["url_cartelera"] as! String)
            //let url = URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FCaf%25C3%25A9&psig=AOvVaw25l6rRws04KbeumRW_uSuY&ust=1684007951376000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCPjK7NDI8P4CFQAAAAAdAAAAABAD")
            cell2.img.kf.setImage(with: url)
            cell2.img.image = cell2.img.image?.withAlignmentRectInsets(UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10))
            
            
           
            return cell2
        }
        
        cell?.img.kf.setImage( with: URL( string:  String(describing: allMovies![indexPath.row].data()["url_carrusel"] as! String) ) )

        return cell!
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        verDetallePelicula(i:indexPath.row)
    }
}

//permide tibujar las celdas
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  miWidthScreen, height: 250)
    }
}
