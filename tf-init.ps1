# Temporarily hide `tests` while running `terraform init` and restore afterwards.
param(
    [Parameter(ValueFromRemainingArguments=$true)]
    $TerraformArgs
)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $scriptDir
try {
    $renamed = $false
    if (Test-Path .\tests) {
        Rename-Item -Path .\tests -NewName 'tests.disabled' -ErrorAction Stop
        $renamed = $true
    }
    terraform init @TerraformArgs
} finally {
    if ($renamed -and Test-Path .\tests.disabled) {
        Rename-Item -Path .\tests.disabled -NewName 'tests' -ErrorAction SilentlyContinue
    }
    Pop-Location
}
