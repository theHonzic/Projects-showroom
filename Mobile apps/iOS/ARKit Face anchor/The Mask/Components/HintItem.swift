//
//  HintItem.swift
//  The Mask
//
//  Created by Jan Janovec on 16.12.2021.
//

import Foundation
import SwiftUI

struct HintItem: View {
    var characterManager: CharacterManager
    var who: Int
    var hint: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0)
        {
            Text("\(characterManager.getHints(integer: self.who)[self.hint].title)")
                .font(.title2)
            Text("\(characterManager.getHints(integer: self.who)[self.hint].text)")
        }
    }
}
