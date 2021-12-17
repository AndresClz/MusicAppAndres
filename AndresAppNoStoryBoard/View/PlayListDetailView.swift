//
//  PlayListDetailView.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 13/12/2021.
//

import UIKit

class PlayListDetailView: UIViewController, TrackAddedToPlaylistDelegate/*, TracksPickerDelegate*/ {
    var tracks = Set<Track>()
    var tracksArray = [Track]()
    
    let mainStack = UIStackView()
        let topStackView = UIView()
            let topStack = UIStackView()
        let tableView = UIView()
            let playListTableView = UITableView()
        let fooView = UIView()
        let fooView2 = UIView()
    
    let playListName = Init(value: UITextField()){
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Playlist name..."
        $0.textColor = .gray
        $0.textAlignment = .left
        $0.backgroundColor = UIColor(named : "BackgroundColor")
        //$0.layoutMargins = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        $0.layer.cornerRadius = 5
        $0.borderStyle = .roundedRect
        //$0.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    let addSongsButton = Init(value: UIButton()){
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        $0.setImage(UIImage(systemName: "plus.app", withConfiguration: config), for: .normal)
//        $0.setImage(UIImage(systemName: "plus.app"), for: .normal)
        
        $0.tintColor = UIColor(named: "TextColor")
     
        //$0.addTarget(self, action: #selector(playPause(_:)), for: .touchUpInside)
    }
    
    public func addTrack(addedTrack: Track) {
//        print("Entre jeje")
//        print("Cancion a añadir \(addedTrack) \n ")
        tracks.insert(addedTrack)
        tracksArray = Array(tracks)
//        print("El array tiene: \(tracks)")
        playListTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setStacks()
        //configurePlayListTable()
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.deleteAndReload(_:)),
                                               name: NSNotification.Name(rawValue: "songRemovedFromLibrary"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.addtracknotificaction(_:)),
                                               name: NSNotification.Name(rawValue: "songAddedFromLibrary"),
                                               object: nil)

    }
    
    @objc func showView() {
        let addTrackToPlaylistVC = AddToPlaylistView()
        addTrackToPlaylistVC.delegate = self
        self.present(addTrackToPlaylistVC, animated: true, completion: nil)
        }
    
    func setStacks(){
        view.addSubview(mainStack)
        mainStack.fitInSuperviewSafeArea()
        mainStack.axis          = .vertical
        mainStack.alignment     = .fill
        mainStack.distribution  = .fillProportionally
        mainStack.spacing       = 10
        mainStack.layoutMargins = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        topStack.axis          = .horizontal
        topStack.alignment     = .fill
        topStack.distribution  = .fillProportionally
        topStack.spacing       = 1
        
        mainStack.addArrangedSubview(topStackView)
        topStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
                topStackView.addSubview(topStack)
                    topStack.fitInSuperview()
                    topStack.addArrangedSubview(playListName)
                    topStack.addArrangedSubview(addSongsButton)
                    addSongsButton.addTarget(self, action:#selector(showView), for: .touchUpInside)

        mainStack.addArrangedSubview(tableView)
            tableView.addSubview(playListTableView)
                playListTableView.fitInSuperview()
                playListTableView.backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(1.5)
                playListTableView.separatorColor = UIColor.systemBlue.withAlphaComponent(0.5)
                playListTableView.separatorStyle = .singleLine
                playListTableView.register(PlaylistCell.self, forCellReuseIdentifier: "reuseIdentifier")

                //playListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "track")
                playListTableView.dataSource = self
                playListTableView.delegate = self
                playListTableView.layer.cornerRadius = 10
            tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
    }
    
//    func configurePlayListTable(){
//        self.view.addSubview(playListTableView)
//        playListTableView.backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(0.5)
//        playListTableView.separatorColor = UIColor.systemBlue.withAlphaComponent(0.5)
//        playListTableView.separatorStyle = .singleLine
//        playListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "track")
//        playListTableView.dataSource = self
//        playListTableView.delegate = self
//        playListTableView.layer.cornerRadius = 10
//    }

    @objc func deleteAndReload(_ notification: NSNotification) {
        
        print("Entro a la notificacion")
        guard let mysong =  notification.object as? Track else {
            print("No llego la cancion a eliminar")
            return
        }
        guard let index: Int = tracksArray.firstIndex(of: mysong) else {
            print("No encontre la cancion")
            return
        }
        print(index)
        tracksArray.remove(at: index)
        
        self.playListTableView.reloadData()

    }
    @objc func addtracknotificaction(_ notification: NSNotification){
        guard let mysong =  notification.object as? Track else {
            print("No llego la cancion a eliminar")
            return
        }
        addTrack(addedTrack: mysong)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.tableView.endEditing(true)
    }
    
}

extension PlayListDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracksArray.count
    }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PlaylistCell
        let track = tracksArray[indexPath.row]
//        cell.backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(1.5)
//        cell.textLabel?.text = track.title
//        cell.preservesSuperviewLayoutMargins = false
//        cell.separatorInset = UIEdgeInsets(top: 2.0, left: 5.0, bottom: 2.0, right: 5.0)
//        cell.layoutMargins = UIEdgeInsets.zero
//        return cell
     
//     let track = misTracks[indexPath.row]
     //print(track)
     cell.displayingTrack = track
//     cell.delegate = delegate
     cell.backgroundColor = UIColor(named: "BackgroundColor")
     cell.setCell()
     return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
   }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
//            var index: Int = indexPath
//            tracksArray.remove(at: index)
//            self.playListTableView.reloadData()
            playListTableView.beginUpdates()
            tracksArray.remove(at: indexPath.row)
            playListTableView.deleteRows(at: [indexPath], with: .fade)
            playListTableView.endUpdates()

        }
    }
}
