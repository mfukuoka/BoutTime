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
    var round: Round?
    var events: [Event]
    let timeAtLimit = 60
    var timeLimit = 60
    var totalRounds = 0
    var roundsInGame = 6
    var correctAnswers = 0

    init() {
        self.events = getEventsFromDb()
        round = Round(events: getRandomEvents())
    }
    
    //returns a new round of events
    func newRound() {
        if let round = round {
            round.events.removeAll()
            round.events = self.getRandomEvents()
        }

    }
    //check if the events are ordered correctly
    func isOrderedCorrectly() -> Bool{
        totalRounds += 1
        if let round = self.round  {
            if round.events[0].year < round.events[1].year {
                if round.events[1].year < round.events[2].year {
                    if  round.events[2].year < round.events[3].year {
                        correctAnswers += 1
                        return true
                    }
                }
            }
        }
       
        return false
    }
    
    //set back to defaults for a new game
    func newGame() {
        totalRounds = 0
        correctAnswers = 0
    }
    //returns true if number of rounds played equals rounds in a game
    func isGameOver() -> Bool {
        if totalRounds == roundsInGame {
            return true
        }
        else{
            return false
        }
        
    }
    //returns a four element array of random events
    func getRandomEvents() -> [Event] {
        
        var container: [Event] = []
        if let round = self.round {
            
            while container.count < 4 {
                
                let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: self.events.count - 1)
                var noMatches = true
                
                //make sure there aren't duplictes
                for event in round.events {
                    if event.description == self.events[randomNumber].description {
                        noMatches = false
                    }
                }
                for event in container {
                    if event.description == self.events[randomNumber].description {
                        noMatches = false
                    }
                }
                
                //add the number to the array to return
                if noMatches {
                    container.append(self.events[randomNumber])
                }
            }
        }
        return container
    }
    
    //sounds for the game
    var correctSound: SystemSoundID = 0
    var incorrectSound: SystemSoundID = 1
    
    //correct sound
    func loadCorrectSound() {
        
        let pathToSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)
    }
    func playCorrectSound() {
        self.loadCorrectSound()
        AudioServicesPlaySystemSound(correctSound)
    }
    
    //sound for incorrect answer
    func loadIncorrectSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &incorrectSound)
    }

    func playIncorrectSound() {
        self.loadIncorrectSound()
        AudioServicesPlaySystemSound(incorrectSound)
    }
}



//establish a dataset
func getEventsFromDb() -> [Event] {
    var events: [Event] = []
    
    let e1 = Event(year: 1993, description: "The MP3 file format was published", url: "https://www.google.com/search?q=The+MP3+file+format+was+published")
    
    let e2 = Event(year: 1994, description: "Linus Torvalds released version 1.0 of the Linux kernel", url: "https://www.google.com/search?q=Linus+Torvalds+released+version+1.0+linux+kernel")
    
    let e3 = Event(year: 1996, description: "Intel released the 200 MHz version of the Pentium Processor", url: "https://en.wikipedia.org/wiki/Timeline_of_computing_1990–99")
    
    let e4 = Event(year: 2015, description: "Windows 10 is released", url: "https://www.google.com/search?q=Windows+10+is+released")
    
    let e5 = Event(year: 1975, description: "Bill Gates and Paul Allen founded Microsoft", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e6 = Event(year: 1978, description: "Microsoft’s first international office founded", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e7 = Event(year: 1981, description: "Microsoft buys the rights to QDOS", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e8 = Event(year: 1980, description: "IBM signs a contract with Microsoft", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e9 = Event(year: 1985, description: "Microsoft Excel is released", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e10 = Event(year: 1990, description: "Windows 3.0 released", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e11 = Event(year: 1995, description: "Windows 95 is released", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e12 = Event(year: 2011, description: "The first 4 terabyte hard drive is released by Seagate", url: "https://www.google.com/search?q=the+first+4+terabyte+hard+drive")
    
    let e13 = Event(year: 1975, description: "Bill Gates hands over CEO to Steve Ballmer", url: "https://en.wikipedia.org/wiki/Timeline_of_Microsoft")
    
    let e14 = Event(year: 2000, description: "AMD released an Athlon clocked at 1 GHz", url: "https://www.google.com/search?q=AMD+released+Athlon+clocked+at+1+GHz")
    
    let e15 = Event(year: 2002, description: "BlackBerry smartphone first released", url: "https://www.google.com/search?q=blackberry+smartphone+first+released")
    
    let e16 = Event(year: 2003, description: "Nvidia released GeForce FX", url: "https://www.google.com/search?q=Nvidia+released+Geforce+FX")
    
    let e17 = Event(year: 2004, description: "Google announces Gmail", url: "https://www.google.com/search?q=Google+announces+Gmail")
    
    let e18 = Event(year: 2005, description: "Xbox 360 is released", url: "https://www.google.com/search?q=xbox+360+is+released")
    
    let e19 = Event(year: 1975, description: "Sony Playstation 3 is released", url: "https://www.google.com/search?q=sony+playstation+3+is+released")
    
    let e20 = Event(year: 2007, description: "The first iPhone was introduced by Apple", url: "https://www.google.com/search?q=first+iphone+was+introduced+by+apple")
    
    let e21 = Event(year: 2009, description: "The online currency Bitcoin is released", url: "https://www.google.com/search?q=bitcoin+is+first+released")
    let e22 = Event(year: 1984, description: "Hewlett Packard releases HP-UX", url: "https://www.google.com/search?q=hp+unix")
    let e23 = Event(year: 1950, description: "Alan turing develops the Turing test", url: "https://www.google.com/search?q=turing+test")
    let e24 = Event(year: 1962, description: "Nick Holonyak invents the LED", url: "https://www.google.com/search?q=holonyak+led")
    let e25 = Event(year: 1891, description: "Nikola Tesla patented his Tesla coil", url: "https://www.google.com/search?q=tesla+coil")
    
    events.append(e1)
    events.append(e2)
    events.append(e3)
    events.append(e4)
    events.append(e5)
    events.append(e6)
    events.append(e7)
    events.append(e8)
    events.append(e9)
    events.append(e10)
    events.append(e11)
    events.append(e12)
    events.append(e13)
    events.append(e14)
    events.append(e15)
    events.append(e16)
    events.append(e17)
    events.append(e18)
    events.append(e19)
    events.append(e20)
    events.append(e21)
    events.append(e22)
    events.append(e23)
    events.append(e24)
    events.append(e25)
    
    return events
}
