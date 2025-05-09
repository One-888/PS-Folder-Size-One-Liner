# Get-FolderSize Script Documentation

## Overview
The `Get-FolderSize` function retrieves the size of all directories in the current location, measuring their total storage in **GB**.

## Function Logic
- **Iterates through all directories** in the current folder.
- **Recursively calculates folder sizes** using `Get-ChildItem` and `Measure-Object`.
- **Formats the size in GB** for better readability using `{0:N2}`.
- **Outputs the result as a formatted table**.

## PowerShell Code
```powershell
function Get-FolderSize {
    Get-ChildItem -Directory -Recurse -Depth 0 | 
    Select-Object BaseName | 
    ForEach-Object -Process { New-Object -TypeName PSObject -Property @{
        Name = $_.BaseName;
        Size = (Get-ChildItem -path $_.BaseName -Recurse -Force -ErrorAction SilentlyContinue | 
                Measure-Object -Property Length -Sum ).Sum / 1gb
    } } | 
    Select-Object Name, @{Name = "Size(GB)"; Expression = { ("{0:N2}" -f ($_.Size)) } } | Format-Table -AutoSize 
}
