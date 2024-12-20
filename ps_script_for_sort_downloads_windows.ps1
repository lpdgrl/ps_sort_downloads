
# The path to the folder that need to be sorted
$PathFolder = "C:\Users\alexs\Downloads"

# $PathFolder ="D:\tmp\test_path"

$year = $null;
Get-ChildItem -Path $PathFolder | ForEach-Object {
    $year = $_.LastWriteTime.Year
    Get-ChildItem -Path $PathFolder | ForEach-Object {
        $newPathFolder = "$PathFolder\$year"
        If (Test-Path $newPathFolder) {
        }
        else {
            New-Item -Path $PathFolder -Name $year -ItemType "directory"
        }
    }
    $fileExtension = $_.Extension.Replace(".", "")
    $file = $_.Name
    $testFolder  = Test-Path -Path $_.FullName -PathType Container

    If ($testFolder -ne $True) {
        Get-ChildItem -Path "$PathFolder" | ForEach-Object {
            If (Test-Path "$PathFolder\$year\$fileExtension" -PathType Container) {
            }
            else {
                New-Item -Path "$PathFolder\$year" -Name $fileExtension -ItemType "directory"
            }
        }
        Move-Item -Path "$PathFolder\$file" -Destination "$PathFolder\$year\$fileExtension\$file"
    }
    else {
        Move-Item -Path "$PathFolder\$file" -Destination "$PathFolder\$year\$file"
    }
}

