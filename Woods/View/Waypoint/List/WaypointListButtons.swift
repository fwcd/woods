import SwiftUI

struct WaypointListButtons<Suffix>: View where Suffix: View {
    let id: UUID
    var name: String? = nil
    @ViewBuilder let labelSuffix: () -> Suffix
    
    @EnvironmentObject private var waypoints: Waypoints
    
    @State private var newListSheetShown: Bool = false
    @State private var newWaypoint = Waypoint()
    @State private var newWaypointSheetShown: Bool = false {
        willSet {
            if newValue != newWaypointSheetShown {
                newWaypoint = Waypoint()
            }
        }
    }
    @State private var clearConfirmationShown: Bool = false
    
    var body: some View {
        Button {
            newListSheetShown = true
        } label: {
            Label("New List", systemImage: "plus")
            labelSuffix()
        }
        .sheet(isPresented: $newListSheetShown) {
            CancelNavigationStack(title: "New Waypoint List") {
                newListSheetShown = false
            } inner: {
                NewWaypointListView { child in
                    waypoints.listTree.insert(under: id, child: child)
                    newListSheetShown = false
                }
                .padding(20)
            }
        }
        let commitNewWaypoint = {
            newWaypoint.generateIdIfEmpty()
            waypoints.listTree[id]?.add(waypoints: [newWaypoint])
                newWaypointSheetShown = false
        }
        Button {
            newWaypointSheetShown = true
        } label: {
            Label("New Waypoint", systemImage: "plus")
            labelSuffix()
        }
        .sheet(isPresented: $newWaypointSheetShown) {
            CancelNavigationStack(title: "New Waypoint") {
                newWaypointSheetShown = false
            } inner: {
                EditWaypointView(waypoint: $newWaypoint, onCommit: commitNewWaypoint)
                    .toolbar {
                        Button("Save", action: commitNewWaypoint)
                    }
            }
        }
        Button {
            clearConfirmationShown = true
        } label: {
            Label("Clear List", systemImage: "trash")
            labelSuffix()
        }
        .confirmationDialog("Are you sure?", isPresented: $clearConfirmationShown) {
            Button {
                for childId in waypoints.listTree[id]?.childs ?? [] {
                    waypoints.listTree.remove(childId)
                }
                waypoints.listTree[id]?.clearWaypoints()
            } label: {
                Text("Clear \(name ?? "List")")
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

extension WaypointListButtons where Suffix == EmptyView {
    init(id: UUID, name: String? = nil) {
        self.init(id: id, name: name) {}
    }
}
