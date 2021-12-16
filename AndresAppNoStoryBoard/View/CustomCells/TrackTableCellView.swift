//
//  TrackTableCellView.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 11/12/2021.
//

import UIKit

class TrackTableCellView: UITableViewCell{
    
    var displayingTrack : Track?
    var parent : ButtonOnCellDelegate?
    
    let cellView        = UIView()
    let trackInfoView   = UIView()
    let trackInfoStack  = UIStackView()
    let cellStack       = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellStack.axis          = .horizontal
        cellStack.alignment     = .fill
        cellStack.distribution  = .fill
        cellStack.spacing       = 5
        cellStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cellStack.isLayoutMarginsRelativeArrangement = true

        trackInfoStack.axis          = .vertical
        trackInfoStack.alignment     = .fill
        trackInfoStack.distribution  = .fillProportionally
        trackInfoStack.spacing       = 2
        trackInfoStack.layoutMargins = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        trackInfoStack.isLayoutMarginsRelativeArrangement = true
        
        self.contentView.addSubview(cellView)
        cellView.fitInSuperview()
        cellView.addSubview(cellStack)
        cellStack.fitInSuperview()
        
        cellStack.addArrangedSubview(trackImage)
        trackInfoView.addSubview(trackInfoStack)
        cellStack.addArrangedSubview(trackInfoView)
        trackInfoStack.fitInSuperview()
        trackInfoStack.addArrangedSubview(trackNameLabel)
        trackInfoStack.addArrangedSubview(trackArtistLabel)
        cellStack.addArrangedSubview(playButton)
        playButton.addTarget(self, action: #selector(self.playButtonTouch(_:)), for: .touchUpInside)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.changeIcon(_:)),
                                               name: NSNotification.Name(rawValue: "changeButtonIcon"),
                                               object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Elementos de UI
    let trackImage = Init(value: UIImageView()){
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.tintColor = .black //UIColor(named: "BackgroundColor")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 60 ).isActive = true
        $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1/1).isActive = true
    }
    let trackNameLabel = Init(value: UILabel()){
        $0.textColor = UIColor(named: "TextColor")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
    }
    let trackArtistLabel = Init(value: UILabel()){
        $0.textColor = UIColor(named: "TextColor")?.withAlphaComponent(0.5)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let playButton = Init(value: playPauseButton()){
        $0.tintColor = .black
        $0.backgroundColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        $0.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        $0.layer.cornerRadius = 30
        $0.layer.borderWidth = 1
        $0.heightAnchor.constraint(equalToConstant: 60 ).isActive = true
        $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
//MARK: - Funciones
    func setCell(){
        guard let displayingTrack = displayingTrack else {return}
        trackNameLabel.text     = displayingTrack.title
        trackArtistLabel.text   = displayingTrack.artist
        trackImage.image        = UIImage(named: "MusicNote")
    }

    @objc func playButtonTouch(_ sender: UIButton!) {
        playButton.performTwoStateSelection()
        guard let parent = parent else { return }
        parent.buttonTouchedOnCell(aCell: self)
    }
    @objc func changeIcon(_ notification: NSNotification){
        guard let mysong =  notification.object as? Track else {
            print("No llego la cancion a eliminar")
            return
        }
        if mysong == displayingTrack {
            print("La cancion \(mysong.title!) es igual a mi")
            playButton.performTwoStateSelection()
        } else {
            //print("No soy igual.")
        }
        //addTrack(addedTrack: mysong)
    }
    
    func buttonIsNotPlayingRealChange(isPlaying: Bool) {
        playButton.performTwoStateSelection()
    }
}
