# Rename existing *.X_X files to *.PDB

$orgPath = "C:\AOSService"
$delim = "\"

# Change working directory to $orgPath
Set-Location $orgPath

# Recursively retrieve all PDB-files from $orgPath
# Note the extra regex filter thru Where-Object as -Filter option is too permissive
Get-ChildItem -Filter *.X_X -Path $orgPath -Recurse -Name | Where-Object {($_.ToUpper()) -match ".X_X$"} | `
foreach { 
    # Store original name
    $fullOldName = $_
    # Split full file name on $delim
    $nameArray = $_.Split($delim)
    # Reassemble directory name
    $dirName = [System.String]::join("\", $nameArray[0..($nameArray.Length-2)])
    # The last entry in the list is the file's base name
    $baseName = $nameArray[($nameArray.Length-1)]
    $baseName = $baseName.Substring(0, $baseName.Length - 4)
    # Change P_B extension into "PDB", effectively enableing the pdb file
    $newName = $baseName + ".pdb"
    $fullNewName = $dirName + $newName
    # If file to be renamed already exists, delete it...
    if (Test-Path $fullNewName) {
        Remove-Item $fullNewName
    }

    # Rename the original file thru Invoke-Expression
    $command =  ("REN   " + $fullOldName + "   " + $newName)
    Write-Output $command
    iex $command
}

Write-Output "Done!" 