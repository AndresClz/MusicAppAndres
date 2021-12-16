//
//  TrackTableView.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 10/12/2021.
//
import UIKit

class TrackTableView: UITableViewController, ButtonOnCellDelegate, AudioPlayerViewModelDelegate {

   override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(TrackTableCellView.self, forCellReuseIdentifier: "reuseIdentifier")
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
        self.tableView.rowHeight = 80
       
    }
// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misTracks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableCellView
        let track = misTracks[indexPath.row]
        cell.displayingTrack = track
        cell.parent = self
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        cell.setCell()
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func buttonTouchedOnCell(aCell: TrackTableCellView) {
        let MusicPlayer = AudioPlayerView()
        guard let playingTrack = aCell.displayingTrack else { return }
        MusicPlayer.playingTrack = playingTrack
        MusicPlayer.delegate = self
        self.present(MusicPlayer, animated: true, completion: nil)
    }
    
    func deleteAndReload(_ song: Track) {
        let index: Int = misTracks.firstIndex(of: song)!
        misTracks.remove(at: index)
        self.tableView.reloadData()
    }

}
