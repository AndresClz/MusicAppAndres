//
//  AudioPlayerView.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 12/12/2021.
//
import UIKit
import AudioPlayer
protocol AudioPlayerViewModelDelegate {
    func deleteAndReload(_ song: Track)
}
class AudioPlayerView: UIViewController {
//MARK: - Atributos y containers
    let mainStack       = UIStackView()
        let topStackView    = UIView()
            let topStack        = UIStackView()
        
        let dataTrackView   = UIView()
            let dataTrackStack  = UIStackView()
                var gifContainer    = UIImageView()
                let controlsView    = UIView()
                    let controlsStack   = UIStackView()
                        let songDataView = UIView()
                            let songDataStack = UIStackView()
    let fooView2 = UIView()

    var playingTrack : Track?
    var viewModel = AudioPlayerViewModel()
    var isPlaying:Bool = true
    var currentTrack : AudioPlayer?
    var myTimer = Timer()
    var audioPlayerVM: AudioPlayerViewModel?
    var delegate: AudioPlayerViewModelDelegate?
    var delegado2 : TrackAddedToPlaylistDelegate?
    
//MARK: - Elementos de UI
    let trackImage = Init(value: UIImageView()){
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.tintColor = UIColor(named: "BackgroundColor")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 60 ).isActive = true
        $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    let dismissButton = Init(value: UIButton()){
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        $0.setImage(UIImage(systemName: "chevron.down", withConfiguration: config), for: .normal)
        $0.tintColor = UIColor(named: "TextColor")
        $0.addTarget(self, action: #selector(dismissMusicPlayerView), for: .touchUpInside)
    }
    
    let moreButton = Init(value: UIButton()){
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        $0.setImage(UIImage(systemName: "ellipsis", withConfiguration: config), for: .normal)
        $0.tintColor = UIColor(named: "TextColor")
        $0.addAction(UIAction(title: "",handler: { (_) in
            print("Default Action")
        }), for: .touchUpInside)
    }
    
    let trackName = Init(value: UILabel()){
        $0.clipsToBounds = true
        $0.textColor = UIColor(named: "TextColor")
        $0.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)

    }
    
    let trackArtist = Init(value: UILabel()){
        $0.clipsToBounds = true
        $0.textColor = UIColor(named: "TextColor")?.withAlphaComponent(0.7)
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)

    }
    
    let playPauseButton = Init(value: UIButton()){
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold)
        $0.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        $0.tintColor = UIColor(named: "TextColor")
        $0.addTarget(self, action: #selector(playPause(_:)), for: .touchUpInside)

    }
    
    let timeSlider = Init(value: UISlider()){
        $0.minimumValue = 0
        $0.thumbTintColor = UIColor(named: "ColorPrincipal")
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(timeSound(sender:)), for: .valueChanged)

    }
    
//MARK: - Funciones de la vista
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(mainStack)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setAllStacks()
        setCell()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGIF()
        playSong()
        
   
    }
    override func viewWillDisappear(_ animated: Bool) {
        isPlaying = false
        //myParent?.buttonIsNotPlaying(isPlaying: isPlaying)
        super.viewWillDisappear(animated)
        currentTrack?.stop()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeButtonIcon")
                                        ,object: self.playingTrack)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape{
            dataTrackStack.axis = .horizontal
        } else {
            dataTrackStack.axis = .vertical
        }
    }
    
//MARK: - Funciones de configuracion de los elementos de UI
    func configureGIF(){
        if let laURL = Bundle.main.url(forResource: "soundWaves", withExtension: ".gif") {
                    let elGIF = UIImage.animatedImage(withAnimatedGIFURL: laURL)
                    gifContainer = UIImageView(image: elGIF)
                    self.view.addSubview(gifContainer)
                }
    }
    
    func setCell(){
        guard let playingTrack = playingTrack else {
            return
        }
        trackName.text     = playingTrack.title
        trackArtist.text   = playingTrack.artist
    }
    
    func setAllStacks(){
        mainStack.fitInSuperviewSafeArea()
        mainStack.axis          = .vertical
        mainStack.alignment     = .fill
        mainStack.distribution  = .fillProportionally
        mainStack.spacing       = 10
        mainStack.layoutMargins = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        topStack.axis          = .horizontal
        topStack.alignment     = .fill
        topStack.distribution  = .fillEqually
        topStack.spacing       = 10
       
        if UIDevice.current.orientation.isLandscape{
            dataTrackStack.axis = .horizontal
        } else {
            dataTrackStack.axis = .vertical
        }
        dataTrackStack.alignment     = .fill
        dataTrackStack.distribution  = .fillEqually
        dataTrackStack.spacing       = 10
        dataTrackStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        dataTrackStack.isLayoutMarginsRelativeArrangement = true
        
        controlsStack.axis          = .vertical
        controlsStack.alignment     = .fill
        controlsStack.distribution  = .fillEqually
        controlsStack.spacing       = 10

        songDataStack.axis          = .vertical
        songDataStack.alignment     = .fill
        songDataStack.distribution  = .fillEqually
        songDataStack.spacing       = 0
        
        mainStack.addArrangedSubview(topStackView)
        topStack.heightAnchor.constraint(equalToConstant: 50).isActive = true

        mainStack.addArrangedSubview(dataTrackView)
        topStackView.addSubview(topStack)
        topStack.fitInSuperview()
        topStack.addArrangedSubview(dismissButton)
        dismissButton.contentHorizontalAlignment = .left
        topStack.addArrangedSubview(fooView2)
        topStack.addArrangedSubview(moreButton)
        moreButton.contentHorizontalAlignment = .right
        
        moreButton.showsMenuAsPrimaryAction = true
        moreButton.menu = addMenuItems()

                
        dataTrackView.addSubview(dataTrackStack)
        dataTrackStack.fitInSuperview()
        
        dataTrackStack.addArrangedSubview(gifContainer)
        dataTrackStack.addArrangedSubview(controlsView)
        controlsView.addSubview(controlsStack)
        controlsStack.fitInSuperview()
        controlsStack.addArrangedSubview(songDataView)
        songDataView.addSubview(songDataStack)
        songDataStack.fitInSuperview()
        songDataStack.addArrangedSubview(trackName)
        songDataStack.addArrangedSubview(trackArtist)
        controlsStack.addArrangedSubview(playPauseButton)
        controlsStack.addArrangedSubview(timeSlider)
        
    }
    
    func playSong(){
        do {
            currentTrack = try AudioPlayer(fileName: "Angeles-Sueno.mp3")
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            currentTrack?.play()
            print("Se encotro la cancion y se esta reproduciendo")
        }
        catch {
            print ("ocurrió un error \(error.localizedDescription)")
        }
        guard let currentTrackDuration = currentTrack?.duration else{
            return
        }
        timeSlider.maximumValue = Float(currentTrackDuration)
    }
//MARK: - Funciones @objc
    
    @objc func updateTimer(){
        guard let tiempo = currentTrack?.currentTime else{ return}
        timeSlider.value = Float(tiempo)
    }
    @objc func dismissMusicPlayerView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func timeSound(sender:UISlider){
        currentTrack?.stop()
        currentTrack?.currentTime = TimeInterval(sender.value)
        currentTrack?.play()
    }
    @objc func playPause(_ sender: Any) {

        if isPlaying {
            currentTrack?.stop()
            isPlaying = false
            let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold)
            playPauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
            
        } else {
            currentTrack?.play()
            isPlaying = true
            let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold)
            playPauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        }

    }
//MARK: - Funciones Normales
    func showAlert(option: String) {
            let alert = UIAlertController(title: title, message: "You touch the \(option) option.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    func addMenuItems() -> UIMenu {
            let menuItems = UIMenu(title: "", options: .displayInline, children: [
                UIAction(title: "Delete from Library", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
                    self.delegate!.deleteAndReload(self.playingTrack!)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "songRemovedFromLibrary"),object: self.playingTrack)
                    self.dismiss(animated: true, completion: nil)
                    print("Deleted from Library")
                }),
                UIAction(title: "Download", image: UIImage(systemName: "arrow.down.app"), handler: { (_) in
                    self.showAlert(option: "Download")
                    DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
                    print("Download")
                }),
                UIAction(title: "Add to a Playlist", image: UIImage(systemName: "text.badge.plus"), handler: { (_) in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "songAddedFromLibrary")
                                                    ,object: self.playingTrack)
                    print("Add to a Playlist")
                }),
                UIAction(title: "Share Song", image: UIImage(systemName: "square.and.arrow.up"), handler: { (_) in
                    let song = [self.playingTrack!.artist!, self.playingTrack!.title]
                                    let ac = UIActivityViewController(activityItems: song as [Any], applicationActivities: nil)
                                    ac.popoverPresentationController?.sourceView = self.view
                                    self.present(ac, animated: true)
                    print("Share Song")
                }),
                UIAction(title: "Love", image: UIImage(systemName: "heart"), handler: { (_) in
                    print("Love")
                })
            ])
            return menuItems
        }
    

}
