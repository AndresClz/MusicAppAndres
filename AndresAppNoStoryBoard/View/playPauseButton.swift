//
//  playPauseButton.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 13/12/2021.
//

import UIKit

class playPauseButton: UIButton {
    var isPlaying: Bool = false

    
    
    func performTwoStateSelection() {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let playIcon = (UIImage(systemName: "play.fill", withConfiguration: config))
        let pauseIcon = (UIImage(systemName: "pause.fill", withConfiguration: config))
        
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
