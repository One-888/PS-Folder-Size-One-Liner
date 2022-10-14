function Get-FolderSize {
   
    Get-ChildItem -Directory -Recurse -Depth 0 | 
    Select-Object FullName | 
    ForEach-Object -Process { New-Object -TypeName PSObject -Property @{Name = $_.FullName; Size = (Get-ChildItem -path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | 
                Measure-Object -Property Length -Sum ).Sum / 1mb
        } } | 
    Select-Object Name, @{Name = "Size(MB)"; Expression = { ("{0:N2}" -f ($_.Size)) } } | Format-Table -AutoSize 
}

# cd\
# C:

# Get-FolderSize
