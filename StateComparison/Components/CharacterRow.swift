//
//  CharacterRow.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name).font(.headline)
                Text("\(character.species) • \(character.status)")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
