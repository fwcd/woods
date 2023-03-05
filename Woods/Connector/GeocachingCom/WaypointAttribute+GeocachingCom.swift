//
//  WaypointAttribute+GeocachingCom.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import Foundation

extension WaypointAttribute {
    var geoachingComId: Int {
        switch self {
        // Permissions
        case .dogs: return 1
        case .bicycles: return 32
        case .motorcycles: return 33
        case .quads: return 34
        case .offRoadVehicles: return 35
        case .snowmobiles: return 36
        case .horses: return 37
        case .campfires: return 38
        case .truckDriverRV: return 46
        
        // Facilities
        case .wheelchairAvailable: return 24
        case .parkingAvailable: return 25
        case .publicTransportation: return 26
        case .drinkingWaterNearby: return 27
        case .publicRestroomsNearby: return 28
        case .telephoneNearby: return 29
        case .picnicTablesNearby: return 30
        case .campingAvailable: return 31
        case .strollerAvailable: return 41
        case .fuelNearby: return 58
        case .foodNearby: return 59
        
        // Equipment
        case .accessOrParkingFee: return 2
        case .climbingGear: return 3
        case .boat: return 4
        case .scubaGear: return 5
        case .flashlightRequired: return 44
        case .uvLightRequired: return 48
        case .snowshoes: return 49
        case .crossCountrySkis: return 50
        case .specialToolRequired: return 51
        case .wirelessBeacon: return 60
        case .treeClimbing: return 64
        
        // Hazards
        case .poisonousPlants: return 17
        case .dangerousAnimals: return 18
        case .ticks: return 19
        case .abandonedMines: return 20
        case .cliffFallingRocks: return 21
        case .hunting: return 22
        case .dangerousArea: return 23
        case .thorns: return 39
        
        // Conditions
        case .recommendedForKids: return 6
        case .takesLessThanAnHour: return 7
        case .scenicView: return 8
        case .significantHike: return 9
        case .difficultClimbing: return 10
        case .mayRequireWading: return 11
        case .mayRequireSwimming: return 12
        case .availableAtAllTimes: return 13
        case .recommendedAtNight: return 14
        case .availableDuringWinter: return 15
        case .stealthRequired: return 40
        case .needsMaintenance: return 42
        case .watchForLivestock: return 43
        case .fieldPuzzle: return 47
        case .nightCache: return 52
        case .parkAndGrab: return 53
        case .abandonedStructure: return 54
        case .shortHike: return 55
        case .mediumHike: return 56
        case .longHike: return 57
        case .seasonalAccess: return 62
        case .touristFriendly: return 63
        case .frontYardPrivateResidence: return 65
        case .teamworkRequired: return 66
        }
    }
    
    init?(geocachingComId: Int) {
        guard let value = Self.allCases.first(where: { $0.geoachingComId == geocachingComId }) else {
            return nil
        }
        self = value
    }
}
