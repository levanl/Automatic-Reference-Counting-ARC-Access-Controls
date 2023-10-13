

// Station Module
class StationModule {
    internal var moduleName: String
    internal var drone: Drone?
    
    init(moduleName: String) {
        self.moduleName = moduleName
    }
    
    func giveTask(task: String) {
        drone?.task = task
    }
}


// Control Center
class ControlCenter: StationModule {
    private var isLockedDown: Bool = false
    private let securityCode: String
    
    init(securityCode: String, moduleName: String) {
        self.securityCode = securityCode
        super.init(moduleName: moduleName)
    }
    
    func lockdown(password: String) {
        if password == securityCode {
            isLockedDown = true
            print("Locked Down")
        } else {
            isLockedDown = false
            print("Did not Lock Down")
        }
    }
    
    func isLocked() {
        isLockedDown ? print("is locked down") : print("is open")
    }
}


// Research Lab
class ResearchLab: StationModule {
    private var samples: [String] = []
   
    func addSamples(sample: String) {
        samples.append(sample)
    }
}


// Life Support System
class LifeSupportSystem: StationModule {
    private var oxygenLevel: Int
    
    init(oxygenLevel: Int, moduleName: String) {
        self.oxygenLevel = oxygenLevel
        super.init(moduleName: moduleName)
    }
    
    func oxygenInfo() {
        print("oxygen Level is \(oxygenLevel)")
    }
}


// Drone Class
class Drone {
    var task: String?
    unowned var assignedModule: StationModule
    weak var missionControlLink: MissionControl?
    
    init(task: String?, assignedModule: StationModule, missionControlLink: MissionControl?) {
        self.task = task
        self.assignedModule = assignedModule
        self.missionControlLink = missionControlLink
    }
    
    func checkTask() {
        if let task = task {
            print("task is: \(task) for \(assignedModule.moduleName).")
        } else {
            print("Drone has no assigned task.")
        }
    }
}


// Space Station
class OrbitronSpaceStation {
    var controlCenter: ControlCenter
    var researchLab: ResearchLab
    var lifeSupportSystem: LifeSupportSystem
    
    init(controlCenter: ControlCenter, researchLab: ResearchLab, lifeSupportSystem: LifeSupportSystem) {
        self.controlCenter = controlCenter
        self.researchLab = researchLab
        self.lifeSupportSystem = lifeSupportSystem
    }
    
    func controlCenterLockdown(password: String) {
        controlCenter.lockdown(password: password)
    }
}


// Mission Control
class MissionControl {
    var spaceStation: OrbitronSpaceStation?
    
    func connectStation(spaceStation: OrbitronSpaceStation) {
        self.spaceStation = spaceStation
    }
    
    func requestControlCenterStatus() {
        spaceStation?.controlCenter.isLocked()
    }
    
    func requestOxygenStatus() {
        spaceStation?.lifeSupportSystem.oxygenInfo()
    }
    
    func requestDroneStatus() {
        spaceStation?.controlCenter.drone?.checkTask()
        spaceStation?.researchLab.drone?.checkTask()
        spaceStation?.lifeSupportSystem.drone?.checkTask()
    }
}


let controlCenter = ControlCenter(securityCode: "3434", moduleName: "Control Center")
let researchLab = ResearchLab(moduleName: "Research Lab")
let lifeSupportSystem = LifeSupportSystem(oxygenLevel: 65, moduleName: "Life Support System")


let controlCenterDrone = Drone(task: nil, assignedModule: controlCenter, missionControlLink: nil)

let researchLabDrone = Drone(task: nil, assignedModule: researchLab, missionControlLink: nil)

let lifeSupportSystemDrone = Drone(task: nil, assignedModule: lifeSupportSystem, missionControlLink: nil)

controlCenter.drone = controlCenterDrone
researchLab.drone = researchLabDrone
lifeSupportSystem.drone = lifeSupportSystemDrone

let orbitronSpaceStation = OrbitronSpaceStation(controlCenter: controlCenter, researchLab: researchLab, lifeSupportSystem: lifeSupportSystem)

let missionControl = MissionControl()

missionControl.connectStation(spaceStation: orbitronSpaceStation)

controlCenter.giveTask(task: "Clean Star Destroyer")
researchLab.giveTask(task: "Collect Samples")
lifeSupportSystem.giveTask(task: "Check oxygen and send Report")

missionControl.requestControlCenterStatus()
missionControl.requestOxygenStatus()
missionControl.requestDroneStatus()

orbitronSpaceStation.controlCenterLockdown(password: "HELPLZLPXL")
orbitronSpaceStation.controlCenterLockdown(password: "3434")


