//
//  AddToPlaylistView.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 14/12/2021.
//
import UIKit
protocol TrackAddedToPlaylistDelegate {
    func addTrack (addedTrack:Track)
    
}

class AddToPlaylistView: UIViewController {
//MARK: - Vistas
    var delegate:TrackAddedToPlaylistDelegate?
    
    let mainStack = UIStackView()
        let topView = UIView()
            let topStack = UIStackView()
        let mainView = UIView()
            let fooview = UIView()
            let songsTable = UITableView()
//MARK: - Elementos de UI
    let dismissButton = Init(value: UIButton()){
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        $0.tintColor = UIColor(named: "TextColor")
        //$0.tintColor = UIColor(named: "TextColor")?.withAlphaComponent(0.5)
        $0.addTarget(self, action: #selector(dismissAddSong), for: .touchUpInside)
    }
    
    let AddSongLabel = Init(value: UILabel()){
        $0.clipsToBounds = true
        $0.text = "Add songs"
        $0.textColor = UIColor(named: "TextColor")
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)

    }
//MARK: - Funciones de View
    override func viewWillAppear(_ animated: Bool) {
        addStacktoView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "BackgroundColor")

    }
//MARK: - Funciones
    func addStacktoView(){
        view.addSubview(mainStack)
        mainStack.axis          = .vertical
        mainStack.alignment     = .fill
        mainStack.distribution  = .fillProportionally
        mainStack.spacing       = 5
        mainStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        topStack.axis          = .horizontal
        topStack.alignment     = .fill
        topStack.distribution  = .fillProportionally
        topStack.spacing       = 0
        
        mainStack.fitInSuperviewSafeArea()
        mainStack.addArrangedSubview(topView)
        topView.addSubview(topStack)
        topStack.fitInSuperview()
        topStack.addArrangedSubview(dismissButton)
        dismissButton.contentHorizontalAlignment = .center
        dismissButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        //dismissButton.backgroundColor = .purple
        topStack.addArrangedSubview(AddSongLabel)
        AddSongLabel.textAlignment = .center
        //AddSongLabel.centerXAnchor.constraint(equalTo: topStack.centerXAnchor).isActive = true
        AddSongLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        //AddSongLabel.backgroundColor = .yellow
        topStack.addArrangedSubview(fooview)
        //fooview.backgroundColor = .blue
        fooview.widthAnchor.constraint(equalToConstant: 30).isActive = true
        topStack.heightAnchor.constraint(equalToConstant: 50).isActive = true


        mainStack.addArrangedSubview(mainView)
        mainView.backgroundColor = .green
        mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        mainView.addSubview(songsTable)
        songsTable.fitInSuperview()
        songsTable.backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(1.5)
        songsTable.separatorColor = UIColor.systemBlue.withAlphaComponent(0.5)
        songsTable.separatorStyle = .singleLine
        songsTable.dataSource = self
        songsTable.delegate = self
        songsTable.register(AddToPlaylistCell.self, forCellReuseIdentifier: "reuseIdentifier")
        songsTable.rowHeight = 80

        
    }
    
    @objc func dismissAddSong(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
//MARK: - TableView Delegate
extension AddToPlaylistView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        misTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! AddToPlaylistCell
        let track = misTracks[indexPath.row]
        //print(track)
        cell.displayingTrack = track
        cell.delegate = delegate
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        cell.setCell()
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
