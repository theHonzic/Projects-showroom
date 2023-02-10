//
//  Card.swift
//  The Mask
//
//  Created by Jan Janovec on 11.10.2021.
//

import SwiftUI

struct Card: View {
    var integer: Int
    var characterManager: CharacterManager = CharacterManager()
    @State var isARPresented: Bool = false
    var body: some View {
        Button(action: {
            self.isARPresented = true
            if (characterManager.getCharacter(integer: self.integer).name) != nil{
                print("\(characterManager.getCharacter(integer: self.integer).name)'s card opened")
            }else{
                print("Unkonown object's card opened")
            }
        }){
            ZStack{
                Color(red: 0.784, green: 0.776, blue: 1, opacity: 0.845)
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image("\(characterManager.getCharacter(integer: self.integer).imagePath)")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("\(characterManager.getCharacter(integer: self.integer).name)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .cornerRadius(30)
            .padding(.all)
            .shadow(color: .gray, radius: 80)
        }
        .sheet(isPresented: $isARPresented){
            ARViewController(isViewPresented: $isARPresented, whoAmI: characterManager.getCharacter(integer: self.integer).name, integer: self.integer)
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(integer: 2)
    }
}
