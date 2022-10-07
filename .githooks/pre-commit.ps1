#Get json 
$packagePath = "./package.json"
$packageJson = Get-Content $packagePath | out-string | ConvertFrom-Json
$packageVersion = [version]$packageJson.version

$packageSolutionPath = "./config/package-solution.json"
$packageSolutionJson = Get-Content $packageSolutionPath | out-string | ConvertFrom-Json
$packageSolutionVersion = [version]$packageSolutionJson.solution.version

Write-Host "package version - " $packageVersion
Write-Host "package solution version - " $packageSolutionVersion

function Compare-Version {
  param (
    $packageVersion,
    $packageSolutionVersion
  )
  $packageVersion = $packageVersion.ToString()
  $packageSolutionVersion = $packageSolutionVersion.ToString()
  $packageSolutionVersion = $packageSolutionVersion.substring(0, $packageSolutionVersion.lastIndexOf('.'))
  if($packageVersion -ne $packageSolutionVersion) {
    Write-Host "Versions do not match."
    exit 1
  } else {
    Write-Host "Versions match."
    return $True
  }
}

Compare-Version $packageVersion $packageSolutionVersion