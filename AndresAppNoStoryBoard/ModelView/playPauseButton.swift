//
//  playPauseButton.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 13/12/2021.
//

import UIKit

class playPauseButton: UIButton {
    var isPlaying: Bool = false

    let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
    let playIcon = (UIImage(systemName: "play.fill"))
    let pauseIcon = (UIImage(systemName: "pause.fill"))
    
    func performTwoStateSelection() {
        if isPlaying == true {
            self.isPlaying = !isPlaying
            self.setImage(playIcon, for: .normal)
            print(isPlaying)
        } else {
            self.isPlaying = !isPlaying
            self.setImage(pauseIcon, for: .normal)
            print(isPlaying)
        }
    }


}
