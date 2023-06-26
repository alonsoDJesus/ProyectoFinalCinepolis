//
//  Conexion.swift
//  EjemploAPIRest
//
//  Created by IMAC18 on 09/03/23.
//

// Token: f094f3a1504a53da44f2e10cab9ab2c4197bd481af7510efac9f7931c2f5c7f7
/**
 Clase con los metodos necesarios para la conexion con API
 */

import Foundation
import Alamofire // Imortacion de libreria necesaria para el proyecto en cuanto al tema de las API's Rest

final class Conexion{
    
    static let con = Conexion() // Objeto para la conexion
    
    private let URLBase = "http://localhost:8888/Peliculas/index.php" // URL base del proyecto
    private let statusOK = 200...299
    //private let TOKEN = "f094f3a1504a53da44f2e10cab9ab2c4197bd481af7510efac9f7931c2f5c7f7"
    
    // Mètodo para obtener la infromaciòn de un usuario en particular.
    func getUser(id: Int){
        /*let URLRequest = "\(URLBase)/users/\(id)" // URL para obtener un usuario en particular.
        
        // Con este mètodo se realiza una peticiòn al servidor para obtener el registro de un usuario
        AF.request(URLRequest,
                   method: .get).validate(statusCode: statusOK).responseDecodable(of: Movie.self){
            response in
            debugPrint(response)
        }*/
    }
    
    // Convertir la funcion a asincrona
    // Clousure success: () -> ()
    func getPeliculaConClousers(
        id: Int,
        success: @escaping (_ usuario: Movie ) -> (),
        fail:  @escaping (_ err: Error? ) -> ())
    {
        let URLRequest = "\(URLBase)?id=\(id)" // URL para obtener un usuario en particular.
        // Con este mètodo se realiza una peticiòn al servidor para obtener el registro de un usuario
        AF.request(URLRequest,
                   method: .get).validate(statusCode: statusOK).responseDecodable(of: Movie.self){
            response in
            if let usuario = response.value{
                success(usuario)
            }else{
                fail(response.error)
            }
        }
    }
    
    // Convertir la funcion a asincrona
    // Clousure success: () -> ()
    func getAll(
        success: @escaping (_ usuario: [Movie] ) -> (),
        fail:  @escaping (_ err: Error? ) -> ())
    {
        let URLRequest = "\(URLBase)" // URL para obtener todos los usuarios.
        // Con este mètodo se realiza una peticiòn al servidor para obtener el registro de todos los usuarios
        AF.request(URLRequest,
                   method: .get).validate(statusCode: statusOK).responseDecodable(of: [Movie].self){
            response in
            if let usuarios = response.value{
                success(usuarios)
            }else{
                fail(response.error)
               
            }
        }
    }
    /*
    
    func addUser(newUser: NewUser,
                 success: @escaping (_ usuario: User ) -> (),
                 fail:  @escaping (_ err: Error? ) -> ())
    {
        let URLRequest = "\(URLBase)/users/"
        let headers: HTTPHeaders = [.authorization(bearerToken: TOKEN)]
        
        AF.request(URLRequest,
                   method: .post,
                   parameters: newUser,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).validate(statusCode: statusOK).responseDecodable(of: User.self)
        {
            response in
            if let usuario = response.value, usuario.id != nil{
                success(usuario)
            }else{
                fail(response.error)
            }
        }
        
    }
    
    func updateUser(id: Int,
                 newUser: NewUser,
                 success: @escaping (_ usuario: User ) -> (),
                 fail:  @escaping (_ err: Error? ) -> ())
    {
        let URLRequest = "\(URLBase)/users/\(id)"
        let headers: HTTPHeaders = [.authorization(bearerToken: TOKEN)]
        
        AF.request(URLRequest,
                   method: .put,
                   parameters: newUser,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).validate(statusCode: statusOK).responseDecodable(of: User.self)
        {
            response in
            if let usuario = response.value, usuario.id != nil{
                success(usuario)
            }else{
                fail(response.error)
            }
        }
        
    }
    
    
    func deleteUser(
        id: Int,
        success: @escaping () -> (),
        fail:  @escaping (_ err: Error? ) -> ())
    {
        let URLRequest = "\(URLBase)/users/\(id)"
        let headers: HTTPHeaders = [.authorization(bearerToken: TOKEN)]
        
        AF.request(URLRequest,
                   method: .delete,
                   headers: headers).validate(statusCode: statusOK).response{
                        response in
                        
            if let error = response.error{
                fail(error)
            }else{
                success()
            }
        }
    }*/
}
