//
//  Model.swift
//  Leagues
//
//  Created by Nick on 09.07.2022.
//

import SwiftUI


// MARK: - Leagues
struct Leagues: Codable {
    let status: Bool
    let data: [League]
}

struct League: Codable, Identifiable {
    let id, name, slug, abbr: String
    let logos: Logos
}

struct Logos: Codable {
    let light: String
    let dark: String
}

// MARK: - Seasons
struct Seasons: Codable {
    let status: Bool
    let data: Season
}

struct Season: Codable {
    let desc: String
    let seasons: [SeasonDescription]
}

struct SeasonDescription: Codable {
    let year: Int
    let startDate, endDate, displayName: String
    let types: [SeasonType]
    var start: String {
        startDate.split(separator: "T")[0].split(separator: "-").reversed().joined(separator: ".")
    }
    var end: String {
        endDate.split(separator: "T")[0].split(separator: "-").reversed().joined(separator: ".")
    }
}

struct SeasonType: Codable {
    let id, name, abbreviation, startDate, endDate: String
    let hasStandings: Bool
}

// MARK: - League Standings
struct Standings: Codable {
    let status: Bool
    let data: StandingsData
}

struct StandingsData: Codable {
    let name, abbreviation, seasonDisplay: String
    let season: Int
    let standings: [Standing]
}

struct Standing: Codable, Identifiable {
    var id: UUID {
        UUID()
    }
    let team: Team
    let note: Note?
    let stats: [Statistic]
    
    var points: Int {
        if let points = stats.first(where: { $0.name == "points" }) {
            return points.value ?? 0
        } else {
           return 0
        }
    }
    
    var rank: Int {
        if let rank = stats.first(where: { $0.name == "rank" }) {
            return rank.value ?? 0
        } else {
           return 0
        }
    }
}

struct Note: Codable {
    let color, noteDescription: String
    let rank: Int

    enum CodingKeys: String, CodingKey {
        case color
        case noteDescription = "description"
        case rank
    }
}
struct Team: Codable {
    let id, uid, location, name: String?
    let abbreviation, displayName, shortDisplayName: String?
    let isActive: Bool?
    let logos: [Logo]?
}

struct Logo: Codable {
    let href: String?
    let width, height: Int?
    let alt: String?
    let rel: [String]?
    let lastUpdated: String?
}


struct Statistic: Codable {
    let name: String?
    let displayName: String?
    let shortDisplayName: String?
    let statDescription: String
    let abbreviation: String?
    let type: String?
    let value: Int?
    let displayValue: String?
    let id, summary: String?

    enum CodingKeys: String, CodingKey {
        case name, displayName, shortDisplayName
        case statDescription = "description"
        case abbreviation, type, value, displayValue, id, summary
    }
}


