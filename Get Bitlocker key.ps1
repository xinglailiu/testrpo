connect-mggraph -scope "BitLockerKey.Read.All, device.read.All"

$Alldevice = Get-MgDevice
$keys = Get-MgInformationProtectionBitlockerRecoveryKey
$output = foreach ( $keyobj in $keys){
            foreach ($deviceobj in $Alldevice){
             if ($deviceobj.deviceid -eq $keyobj.deviceid){
              New-Object -TypeName PSObject -Property 
              @{
              displayname = $deviceobj.displayname
              deviceid = $keyobj.deviceid
              RecoveryKey = (Get-MgInformationProtectionBitlockerRecoveryKey -BitlockerRecoveryKeyId $keyobj.Id -Property "key").key
      }
    }  
  }
} 

$output | export-csv -path ".\AADBitlockerKeys_$(get-date -f yyyy-MM-dd).csv" -NoTypeInformation


