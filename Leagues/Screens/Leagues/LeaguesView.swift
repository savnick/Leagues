//
//  ContentView.swift
//  Leagues
//
//  Created by Nick on 09.07.2022.
//

import SwiftUI

struct LeaguesView: View {
    @StateObject var items = Remote(
        url: URL(string: "https://api-football-standings.azharimm.site/leagues")!,
        transform: { try? JSONDecoder().decode(Leagues.self, from: $0) }
    )
    
    var body: some View {
        NavigationView {
            Group {
                if let response = items.value {
                    List(response.data) { league in
                        HStack {
                            NavigationLink {
                                SeasonsView(id: league.id)
                                    .navigationTitle(league.name)
                            } label: {
                                LogoView(URL(string: league.logos.light)!)
                                    .frame(width: 55, height: 55)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(league.name)
                                        .fontWeight(.bold)
                                    Text(league.abbr)
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                } else {
                   ProgressView()
                        .onAppear { items.load() }
                }
            }
            .navigationTitle("Leagues")
        }
    }
}

struct LeaguesView_Previews: PreviewProvider {
    static var previews: some View {
        LeaguesView()
    }
}
