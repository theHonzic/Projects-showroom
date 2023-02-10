//
//  HintSheet.swift
//  The Mask
//
//  Created by Jan Janovec on 10.12.2021.
//

import SwiftUI

struct HintSheet: View {
    @Binding var isViewPresented: Bool
    var integer: Int
    var characterManager: CharacterManager = CharacterManager()
    var body: some View {
        VStack{
            CircleView(image: characterManager.getCharacter(integer: self.integer).imagePath)
                .frame(width: 300)
                .padding(.horizontal)
            VStack(alignment: .leading){
                Text("\(characterManager.getCharacter(integer: self.integer).name)'s animation guide")
                    .font(.title)
                Divider()
                VStack(alignment: .leading, spacing: 20.0){
                    if characterManager.getHints(integer: self.integer).count > 0 {
                        if characterManager.getHints(integer: self.integer).count == 3{
                            if characterManager.getHints(integer: self.integer)[0].text != "" || characterManager.getHints(integer: self.integer)[0].title != "" {
                                HintItem(characterManager: self.characterManager, who: self.integer, hint: 0)
                            }
                            
                            Divider()
                            
                            if characterManager.getHints(integer: self.integer)[1].title != "" || characterManager.getHints(integer: self.integer)[1].text != "" {
                                HintItem(characterManager: self.characterManager, who: self.integer, hint: 1)
                            }

                            Divider()
                            
                            if characterManager.getHints(integer: self.integer)[0].text != "" || characterManager.getHints(integer: self.integer)[0].title != "" {
                                HintItem(characterManager: self.characterManager, who: self.integer, hint: 2)
                            }
                        }
                        if characterManager.getHints(integer: self.integer).count == 2{
                            if characterManager.getHints(integer: self.integer)[0].text != "" || characterManager.getHints(integer: self.integer)[0].title != "" {
                                HintItem(characterManager: self.characterManager, who: self.integer, hint: 0)
                            }
                            
                            Divider()
                            
                            if characterManager.getHints(integer: self.integer)[1].title != "" || characterManager.getHints(integer: self.integer)[1].text != "" {
                                HintItem(characterManager: self.characterManager, who: self.integer, hint: 1)
                            }

                        }
                        if characterManager.getHints(integer: self.integer).count == 1{
                            if characterManager.getHints(integer: self.integer)[0].text != "" || characterManager.getHints(integer: self.integer)[0].title != "" {
                                HintItem(characterManager: self.characterManager, who: self.integer, hint: 0)
                            }
                        }
                        
                    }
                    
                    
                }
            }
        }
        .padding(.horizontal)
    }
}

struct HintSheet_Previews: PreviewProvider {
    static var previews: some View {
        HintSheet(isViewPresented: .constant(true), integer: 1)
    }
}


