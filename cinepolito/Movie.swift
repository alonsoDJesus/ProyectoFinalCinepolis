//
//  User.swift
//  EjemploAPIRest
//
//  Created by IMAC18 on 09/03/23.
//

/**
    Estructura de un Usuario para almacenar datos de usuario.
 */

import Foundation
import Kingfisher

struct Movie: Decodable{ // Decodable permite la decodificacion automàtica de arcivos JSON
    
    // Variables para los datos del usuario
    var id: String?
    var titulo: String?
    var sinopsis: String?
    var genero: String?
    var idioma: String?
    var horarios: String?
    var clasificacion: String?
    var url_portada: String?
    var duracion: String?
    var url_portada_hero: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case titulo
        case sinopsis
        case genero
        case idioma
        case horarios
        case clasificacion
        case url_portada
        case duracion
        case url_portada_hero
        //case id = "id"
    }
}

