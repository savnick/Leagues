//
//  SeasonDetailView.swift
//  Leagues
//
//  Created by Nick on 09.07.2022.
//

import SwiftUI

struct StandingsView: View {
    @ObservedObject var items: Remote<Standings>
    
    init(id: String, year: String) {
        items = Remote(
            url: URL(string: "https://api-football-standings.azharimm.site/leagues/\(id)/standings?season=\(year)&sort=asc")!,
            transform: { try? JSONDecoder().decode(Standings.self, from: $0) }
        )
    }
    
    var body: some View {
        if let response = items.value {
            List(response.data.standings) { standing in
                HStack {
                    if standing.rank > 0 && standing.points > 0 {
                        Text("\(standing.rank). ")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    Text(standing.team.displayName!)
                        .font(.callout)
                    Spacer()
                    Text("\(standing.points)")
                        .font(.body)
                }
                .listRowSeparator(.hidden)
            }
        } else {
            ProgressView().onAppear { items.load() }
        }
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView(id: "ger.1", year: "2020")
    }
}

