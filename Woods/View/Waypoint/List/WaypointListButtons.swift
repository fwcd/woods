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
        .popover(isPresented: $newListSheetShown) {
            PopoverNavigation(title: "New Waypoint List") {
                newListSheetShown = false
            } inner: {
                NewWaypointListView { child in
                    waypoints.listTree.insert(under: id, child: child)
                    newListSheetShown = false
                }
                #if !os(macOS)
                .padding(10)
                #endif
            }
        }
        
        Button {
            newWaypointSheetShown = true
        } label: {
            Label("New Waypoint", systemImage: "plus")
            labelSuffix()
        }
        .popover(isPresented: $newWaypointSheetShown) {
            PopoverNavigation(title: "New Waypoint") {
                newWaypointSheetShown = false
            } inner: {
                WaypointEditorView(waypoint: $newWaypoint, onCommit: commitNewWaypoint)
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
    
    private func commitNewWaypoint() {
        newWaypoint.generateIdIfEmpty()
        waypoints.listTree[id]?.add(waypoints: [newWaypoint])
        newWaypointSheetShown = false
    }
}

extension WaypointListButtons where Suffix == EmptyView {
    init(id: UUID, name: String? = nil) {
        self.init(id: id, name: name) {}
    }
}
