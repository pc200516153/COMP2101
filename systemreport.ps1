$hardwaredescription= Get-WmiObject Win32_computersystem
Write-Host "Hardware description"
$hardwaredescription

$operatingsystem = Get-WmiObject Win32_operatingsystem
Write-Host "operating system"
$operatingsystemname= $operatingsystem.caption
Write-Host "Operatingsystem Name: $operatingsystemname"
$operatingsystemversion = $operatingsystem.version
Write-Host "Operatingsystem Version:$operatingsystemversion"
Write-Host




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

Write-Host

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






