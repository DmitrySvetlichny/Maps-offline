//
//  DeviceMemoryService.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 01.10.2022.
//

import UIKit

class DeviceMemoryService {
    
    var progressValue: Double {
        let progress = usedDiskSpaceInBytes / totalDiskSpaceInBytes
        return progress
    }
    
    var freeDiskSpace: String {
        return ByteCountFormatter.string(fromByteCount: Int64(freeDiskSpaceInBytes), countStyle: ByteCountFormatter.CountStyle.file)
    }
    
    private var totalDiskSpaceInBytes: Double {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.doubleValue
            return space!
        } catch {
            return 0
        }
    }
    
    private var freeDiskSpaceInBytes: Double {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.doubleValue
            return freeSpace!
        } catch {
            return 0
        }
    }
    
    private var usedDiskSpaceInBytes: Double {
        let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
        return usedSpace
    }
}

