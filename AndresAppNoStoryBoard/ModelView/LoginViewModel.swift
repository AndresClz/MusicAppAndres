//
//  LoginViewModel.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 10/12/2021.
//

import UIKit
import CoreData

class LoginViewModel: UIViewController {
    let model: Registered = Registered()
    var validUser = false
    var errorAnimation : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func botonLoginTouch(user:String?, pass:String?) {
        
        guard let username = user, !username.isEmpty else{
            print("Email Vacio")
            errorAnimation = 1
            //self.showSimpleAlert("Email Vacio")
            return
        }
        
        guard username.lowercased().isValidEmail() else{
            //self.showSimpleAlert("Email Invalido")
            errorAnimation = 1
            return
        }
        guard let password = pass, !password.isEmpty else{
            //self.showSimpleAlert("Password Vacia")
            errorAnimation = 2
            return
        }
        guard password.isValidPassword() else{
            //self.showSimpleAlert("Password no valida")
            errorAnimation = 2
            return
        }
        if model.user1.user == user && model.user1.pass == password{
            validUser = true
        } else {
            errorAnimation = nil
            print("Usuario no encontrado")
        }
    }
    
    func savedData() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.managedObjectContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracklist")
            request.returnsObjectsAsFaults = false
            
            do {
                let result = try context!.fetch(request) // fetch nos da elementos no nulos
                misTracks = [Track]()
                
                for data in result as! [NSManagedObject] {
                    let title = data.value(forKey: "title") as? String
                    let artist = data.value(forKey: "artist") as? String
                    let song_id = data.value(forKey: "song_id") as? String
                    let album = data.value(forKey: "album") as? String
                    let genre = data.value(forKey: "genre") as? String
                    
                    let track = Track(title: title ?? "",
                                      artist: artist ?? "",
                                      album: album ?? "",
                                      songId: song_id ?? "",
                                      genre: genre ?? ""
                    )
                    misTracks.append(track)
                }
                
            } catch {
                print("Falle al obtener info de la BD \(error), \(error.localizedDescription)")
            }
            
    //        if false {
            self.downloadTracks()
    //        }
            
        }
    
    func downloadTracks() {
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
          let context = appDelegate.managedObjectContext
          
          RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in
              misTracks = [Track]()
              if let _data = data {
                  misTracks = _data
                  if let _context = context {
                      // Eliminar contenido
                      let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tracklist")
                      let deleteRquest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                      do {
                          try appDelegate.persistentStoreCoordinator?.execute(deleteRquest, with: _context)
                      } catch {
                          print(error)
                      }
                      //Fin eliminar contenido
                      
                      //Agregar contenido a CoreData
                      for item in _data {
                          let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "Tracklist", into: _context)
                          tracksEntity.setValue(item.artist, forKey: "artist")
                          tracksEntity.setValue(item.title, forKey: "title")
                          tracksEntity.setValue(item.songId , forKey: "song_id")
                          tracksEntity.setValue(item.genre, forKey: "genre")
                          tracksEntity.setValue(item.album, forKey: "album")
                          
                          do {
                              try context?.save()
                          } catch {
                              print("No se guardo la info \(error), \(error.localizedDescription)" )
                          }
                      }
                  }
              }
          }
      }

}
