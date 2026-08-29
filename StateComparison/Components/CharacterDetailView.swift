//
//  CharacterDetailView.swift
//  StateComparison
//
//  Created by Kazbek  on 09.06.2026.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.2).frame(height: 300)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))

                detailRow("Статус", character.status)
                detailRow("Вид", character.species)
                detailRow("Пол", character.gender)
                detailRow("Происхождение", character.origin.name)
                detailRow("Текущая локация", character.location.name)
                detailRow("Эпизодов", "\(character.episode.count)")
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title).foregroundStyle(.secondary)
            Spacer()
            Text(value).fontWeight(.medium)
        }
        .padding(.vertical, 2)
    }
}
