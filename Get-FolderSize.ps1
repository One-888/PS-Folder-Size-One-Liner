function Get-FolderSize {
    Get-ChildItem -Directory -Recurse -Depth 0 | 
    Select-Object BaseName | 
    ForEach-Object -Process { New-Object -TypeName PSObject -Property @{Name = $_.BaseName; Size = (Get-ChildItem -path $_.BaseName -Recurse -Force -ErrorAction SilentlyContinue | 
                Measure-Object -Property Length -Sum ).Sum / 1gb
        } } | 
    Select-Object Name, @{Name = "Size(GB)"; Expression = { ("{0:N2}" -f ($_.Size)) } } | Format-Table -AutoSize 
}

# cd\
# C:

# Get-FolderSize
