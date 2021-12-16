//
//  Protocols.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 11/12/2021.
//

import Foundation

protocol ButtonOnCellDelegate{
    func buttonTouchedOnCell(aCell : TrackTableCellView)
}

protocol PlayPauseButtonIconDelegate{
    func buttonIsNotPlaying(isPlaying: Bool)
}

//protocol CellButtonLogoDelegate{
//    func buttonIsNotPlayingRealChange(isPlaying: Bool)
//}
