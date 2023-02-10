//
//  Grid.swift
//  The Mask
//
//  Created by Jan Janovec on 12.10.2021.
//

import SwiftUI

struct Grid: View {
    var characterManager: CharacterManager = CharacterManager()
    
    var body: some View {
        let characterCount: Int = characterManager.getCount()
        let rowCount: Int = characterCount/2
        
        if characterCount%2==0{
            ScrollView(){
            HStack{
                VStack{//prvni sloupec - sude
                    ForEach(0..<characterCount){item in
                        if item%2==0 {
                            Card(integer: item)
                        }
                    }
                    
                }
                VStack{//druhy sloupec - liche
                    ForEach(0..<characterCount){item in
                        if item%2==1 {
                            Card(integer: item)
                        }
                        
                    }
                }
                
            }
            
        }
        }else{
            ScrollView(){
                VStack{
                HStack{
                    VStack{//prvni sloupec - sude
                        ForEach(0..<characterCount){item in
                            if item%2==0 {
                                if item+1 != characterCount{
                                    Card(integer: item)
                                }
                                
                            }
                        }
                        
                    }
                    VStack{//druhy sloupec - liche
                        ForEach(0..<characterCount){item in
                            if item%2==1 {
                                Card(integer: item)
                            }
                            
                        }
                    }
                    
                }
                    //posledni character:
                    
                    Card(integer: characterCount-1)
            }
            }
        }
        
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid().previewInterfaceOrientation(.portrait)
    }
}
