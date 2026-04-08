$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$targetFile = Join-Path $repoRoot "index.html"

if (-not (Test-Path -LiteralPath $targetFile)) {
  throw "Could not find index.html at $targetFile"
}

$content = Get-Content -LiteralPath $targetFile -Raw
$pattern = 'const APP_VERSION = "(\d+)\.(\d+)\.(\d+)";'
$match = [regex]::Match($content, $pattern)

if (-not $match.Success) {
  throw "APP_VERSION marker not found in index.html"
}

$major = [int]$match.Groups[1].Value
$minor = [int]$match.Groups[2].Value
$patch = [int]$match.Groups[3].Value + 1
$nextVersion = "$major.$minor.$patch"
$replacement = "const APP_VERSION = `"$nextVersion`";"
$updatedContent = [regex]::Replace($content, $pattern, $replacement, 1)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

[System.IO.File]::WriteAllText($targetFile, $updatedContent, $utf8NoBom)
Write-Output "Bumped version to $nextVersion"
