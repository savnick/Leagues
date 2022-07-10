//
//  SeasonsView.swift
//  Leagues
//
//  Created by Nick on 09.07.2022.
//

import SwiftUI

struct SeasonsView: View {
    @ObservedObject var items: Remote<Seasons>
    private var id: String
    init(id: String) {
        self.id = id
        items = Remote(
            url: URL(string: "https://api-football-standings.azharimm.site/leagues/\(id)/seasons")!,
            transform: { try? JSONDecoder().decode(Seasons.self, from: $0) }
        )
    }
    
    var body: some View {
        if let response = items.value {
            List(response.data.seasons, id: \.year) { season in
                NavigationLink {
                    StandingsView(id: id, year: String(season.year))
                        .navigationTitle("Season: \(String(season.year))")
                } label: {
                    VStack(alignment: .leading) {
                        Text("Season: \(String(season.year))")
                            .fontWeight(.bold)
                        Text("\(season.start) - \(season.end)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                .listRowSeparator(.hidden)
            }
        } else {
            ProgressView().onAppear { items.load() }
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView(id: "ger.1")
    }
}
