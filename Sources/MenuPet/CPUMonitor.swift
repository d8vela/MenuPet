import Foundation

class CPUMonitor {
    var currentCPU: Double = 0
    var onCPUUpdate: ((Double) -> Void)?
    private var timer: Timer?
    private var previousTotal: UInt64 = 0
    private var previousIdle: UInt64 = 0

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.measureCPU()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func measureCPU() {
        var numCPUs: natural_t = 0
        var cpuInfo: processor_info_array_t?
        var numCPUInfo: mach_msg_type_number_t = 0

        let result = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO,
                                         &numCPUs, &cpuInfo, &numCPUInfo)
        guard result == KERN_SUCCESS, let info = cpuInfo else { return }

        defer {
            let size = vm_size_t(numCPUInfo) * vm_size_t(MemoryLayout<integer_t>.size)
            vm_deallocate(mach_task_self_, vm_address_t(bitPattern: info), size)
        }

        var totalTicks: UInt64 = 0
        var idleTicks: UInt64 = 0

        for i in 0..<Int(numCPUs) {
            let offset = i * Int(CPU_STATE_MAX)
            let user = UInt64(info[Int(CPU_STATE_USER) + offset])
            let system = UInt64(info[Int(CPU_STATE_SYSTEM) + offset])
            let idle = UInt64(info[Int(CPU_STATE_IDLE) + offset])
            let nice = UInt64(info[Int(CPU_STATE_NICE) + offset])
            totalTicks += user + system + idle + nice
            idleTicks += idle
        }

        let totalDiff = totalTicks - previousTotal
        let idleDiff = idleTicks - previousIdle

        if totalDiff > 0 {
            currentCPU = Double(totalDiff - idleDiff) / Double(totalDiff) * 100.0
            currentCPU = min(currentCPU, 100.0)
        }

        previousTotal = totalTicks
        previousIdle = idleTicks

        onCPUUpdate?(currentCPU)
    }
}
