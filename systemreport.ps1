#this is the function to get hardware information of the system
function SystemHardwareInfo{
$hardwaredescription= Get-WmiObject Win32_computersystem
Write-Host "Hardware description"
$hardwaredescription
}

#This is the function to get operating system information 
function OperatingSystemInfo{
$operatingsystem = Get-WmiObject Win32_operatingsystem
Write-Host "Operating system"
$operatingsystemname= $operatingsystem.caption
Write-Host "Operatingsystem Name: $operatingsystemname"
$operatingsystemversion = $operatingsystem.version
Write-Host "Operatingsystem Version:$operatingsystemversion"
}

#This is to create space 
Write-Host


#This is the function to get the processor information
function ProcessorInormation{
$processordescription=Get-WmiObject Win32_processor
Write-Host "Processor Information"
$processorname = $processordescription.Name
Write-Host "ProcessorName: $processorname"
$processorSpeed = $processordescription.MaxClockSpeed
Write-Host "Processor Speed : $processorSpeed"
$Numberofcores = $processordescription.NumberofCores
Write-Host "Number of Cores : $numberofcores"

$L1CacheSize = $processordescription.L1cacheSize
Write-Host "L1 Cache Size : $L1CacheSize"
$L2CacheSize = $processordescription.L2cachesize
Write-Host "L2 Cache Size : $L2Cachesize"
$L3CacheSize = $processordecription.L3Cachesize
Write-Host "L3 Cache Size : $L3cachesize"
}

#This is to create space
Write-Host

#This is the function to get Ram information of the system
function RamInformation{
Write-Host "RAM Information"
$totalcapacity = 0
get-wmiobject -class win32_physicalmemory | 
foreach {
 	new-object -TypeName psobject -Property @{
 	Manufacturer = $_.manufacturer
	Description = $_.description
 	"Speed(MHz)" = $_.speed
 	"Size(MB)" = $_.capacity/1mb
  	Bank = $_.banklabel
 	Slot = $_.devicelocator
        }
 	$totalcapacity += $_.capacity/1mb
} |
ft -auto Manufacturer, "Size(MB)",Description,"Speed(MHz)",Bank,Slot
"Total RAM Installed: ${totalcapacity}MB"
}

#This is the function to get Disk Information of the system
function DiskInformation{
Write-Host "Physical Disk Drivers Summary"
$diskdrives = Get-CIMInstance CIM_diskdrive

 foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
           }
      }
  }
}

#This is the function to get network configuration of the system
function NetworkConfiguration{
Write-Host "Network Adapter Configuration"
$adapters = Get-WmiObject Win32_NetworkAdapter
$filteredadapters = $adapters | where-object {$_.netenabled -eq $true}
$filteredadapters | format-table
}

#This is the function to get Video Card Information of the system
function VideoCardInformation{
Write-Host "video Card Information"
$VideoCardInfo = Get-WmiObject win32_videocontroller
foreach ($video in $VideoCardInfo) {
         new-object -TypeName psobject -Property @{
         Vendor=$video.VideoProcessor
         Description =$video.description		
	}
 }
format-list Vendor,Description

}


#This is to implement all the functions
$systemHardware=SystemHardwareInfo
$systemHardware
$operatingsystem=OperatingSystemInfo
$operatingsystem
$ProcessorDetail=ProcessorInormation
$ProcessorDetail
$MemoryInformation=RamInformation
$MemoryInformation
$DiskDetail=DiskInformation
$DiskDetail
$NetworkInformation=NetworkConfiguration
$NetworkInformation
$VideoCardDetail =VideoCardInformation
$VideoCardDetail 










