#
# Copyright (C) Microsoft. All rights reserved.
#

<#
.Synopsis
    This Windows PowerShell script shows how to enumerate all existing keyboard filter
    rules and how to disable them by setting the Enabled property directly.
.Description
    For each instance of WEKF_PredefinedKey, WEKF_CustomKey, and WEKF_Scancode,
    set the Enabled property to false/0 to disable the filter rule, thus
    allowing all key sequences through the filter.
.Parameter ComputerName
    Optional parameter to specify the remote computer that this script should
    manage.  If not specified, the script will execute all WMI operations
    locally.
#>

param(
    [String]$ComputerName
)

$CommonParams = @{"namespace"="root\standardcimv2\embedded"}
$CommonParams += $PSBoundParameters

Get-WMIObject -class WEKF_PredefinedKey @CommonParams |
    foreach {
        if ($_.Enabled) {
            $_.Enabled = 0;
            $_.Put() | Out-Null;
            Write-Host Disabled $_.Id
        }
    }

Get-WMIObject -class WEKF_CustomKey @CommonParams |
    foreach {
        if ($_.Enabled) {
            $_.Enabled = 0;
            $_.Put() | Out-Null;
            Write-Host Disabled $_.Id
        }
    }

Get-WMIObject -class WEKF_Scancode @CommonParams |
    foreach {
        if ($_.Enabled) {
            $_.Enabled = 0;
            $_.Put() | Out-Null;
            "Disabled {0}+{1:X4}" -f $_.Modifiers,$_.Scancode
        }
    }
