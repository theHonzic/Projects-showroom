//
//  Characters.swift
//  The Mask
//
//  Created by Jan Janovec on 12.10.2021.
//

import Foundation

struct Hint{
    var title: String
    var text: String
}

struct Character{
    var name: String
    var imagePath: String
    var hints: [Hint]
}


class CharacterManager{
    private var characters: [Character] = []
    
    init() {
        self.characters.append(Character(name: "Witch",
                                         imagePath: "witch",
                                         hints:
                                            [Hint(title: "Otevření úst",
                                                      text: "Při otevření úst se ústa roztočí kolem dýně"),
                                                 Hint(title: "Roztáhnutí očí",
                                                      text: "Při roztáhnutí očí se posunou oči"),
                                                 Hint(title: "EyeBrows something",
                                                      text: "if eyebrows raise...")]))
        
        
        self.characters.append(Character(name: "Pumpkin",
                                         imagePath: "pumpkin",
                                         hints:
                                            [Hint(title: "Zavření očí",
                                                      text: "Při zavření očí se zavřou dýni oči"),
                                                 Hint(title: "Roztáhnutí očí",
                                                      text: "Při roztáhnutí očí se posunou oči"),
                                                 Hint(title: "EyeBrows something",
                                                      text: "if eyebrows raise...")]))
        
        
        self.characters.append(Character(name: "Iron Man",
                                         imagePath: "ironMan",
                                         hints:
                                            []))
        
        
        self.characters.append(Character(name: "Skull",
                                         imagePath: "skeleton",
                                         hints:
                                            [Hint(title: "Otvírání úst",
                                                  text: "Při otevření úst se ústa otevřou i kostlivci"),
                                             Hint(title: "Roztáhnutí očí",
                                                  text: "Při roztáhnutí očí se posunou oči"),
                                             Hint(title: "EyeBrows something",
                                                  text: "if eyebrows raise...")]))
        
        
        self.characters.append(Character(name: "Clown",
                                         imagePath: "clown",
                                         hints:
                                            [Hint(title: "Otevření úst",
                                                  text: "Při otevření úst se ústa roztočí kolem dýně"),
                                             Hint(title: "Roztáhnutí očí",
                                                  text: "Při roztáhnutí očí se posunou oči"),
                                             Hint(title: "EyeBrows something",
                                                  text: "if eyebrows raise...")]))
        
        
        self.characters.append(Character(name: "Robot",
                                         imagePath: "robot",
                                         hints:
                                            [Hint(title: "Otevření úst",
                                                  text: "Při otevření úst robot začne mluvit"),
                                             Hint(title: "Zavření očí",
                                                  text: "Při zavření očí se oči zavřou robotovi"),
                                             Hint(title: "Zvednutí obočí",
                                                  text: "Po zvednutí obočí vystřelí robotu lasery z očí")]))
        
        
    }
    
    func getCharacter(integer: Int) -> Character {
        return characters[integer]
    }
    
    func getCharacters() -> [Character] {
        return characters
    }
    
    func getCount() -> Int {
        return characters.count
    }
    
    func getHints(integer: Int) -> [Hint]{
        return characters[integer].hints
    }
}
