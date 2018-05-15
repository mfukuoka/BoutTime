//
//  Game.swift
//  BoutTime
//
//  Created by thechemist on 5/8/18.
//  Copyright © 2018 mfukuoka. All rights reserved.
//

import Foundation
import GameKit

class Game {
    var round: Round!
    init() {
        self.round = Round()
    }
    //returns a new round of events
    func newRound() {
        round.events =  getRandomEvents()
    }
    //return a random event
    func getRandomEvents() -> [Event] {
        var events: [Event] = []

        while events.count < 4 {
            let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: round.events.count - 1)
            var noMatches = true
            for event in events {
                if event.description == round.events[randomNumber].description {
                    noMatches = false
                }
            }
            if noMatches {
                events.append(round.events[randomNumber])
            }
        }
  
        return events
    }

}
