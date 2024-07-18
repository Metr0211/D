param(
    [double]$increment = 0.002,
    [double]$start = 0.5,
    [double]$end = 0.8,
    [int]$samples = 20
)

function Is-Admin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function main {
    if (-not (Is-Admin)) {
        Write-Host "Error: Administrator privileges required"
        return 1
    }

    $resultsFile = "results.txt"
    if (Test-Path $resultsFile) {
        Remove-Item $resultsFile -Force
    }

    Write-Host "Approximate worst-case estimated time for completion: $([math]::Round(($end - $start) * 102 * $samples / 6E4, 2))mins"
    Write-Host "Worst-case is determined by assuming Sleep(1) = ~2ms with 1ms Timer Resolution"
    Write-Host "Start: $($start)ms, End: $($end)ms, Increment: $($increment)ms, Samples: $($samples)"

    Set-Location $PSScriptRoot

    foreach ($dependency in @("SetTimerResolution.exe", "MeasureSleep.exe")) {
        if (-not (Test-Path $dependency)) {
            Write-Host "Error: $($dependency) does not exist in the current directory"
            return 1
        }
    }

    foreach ($i in ($start..$end)) {
        Write-Host "Info: Benchmarking $($i)ms"

        Start-Process ".\SetTimerResolution.exe" -ArgumentList "--resolution", ($i * 1E4), "--no-console" -Wait

        Start-Sleep -Seconds 1

        $output = .\MeasureSleep.exe --samples $samples
        $outputLines = $output -split "`n"

        $avg = $null
        $stdev = $null

        foreach ($line in $outputLines) {
            if ($line -match "Avg: (.*)") {
                $avg = $matches[1] -replace "Avg: "
            } elseif ($line -match "STDEV: (.*)") {
                $stdev = $matches[1] -replace "STDEV: "
            }
        }

        "$($i), $([math]::Round([double]$avg, 3)), $($stdev)" | Out-File $resultsFile -Append

        Stop-Process -Name "SetTimerResolution" -ErrorAction SilentlyContinue
    }

    Stop-Process -Name "prime95" -Force
    Write-Host "Info: $resultsFile saved."

    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $desktopResultsFile = Join-Path -Path $desktopPath -ChildPath $resultsFile
    Move-Item -Path $resultsFile -Destination $desktopResultsFile -Force
    Write-Host "Info: $resultsFile moved to $desktopResultsFile."
}
