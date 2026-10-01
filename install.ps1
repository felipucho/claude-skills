# Instala todas las skills de skills.txt en ~\.claude (global).
# Agrupa por fuente (un clone por repo) y corre las fuentes en paralelo.
Set-Location $PSScriptRoot

npm.cmd install -g skills | Out-Null
$skills = Join-Path $env:APPDATA 'npm\skills.cmd'

$groups = [ordered]@{}
Get-Content skills.txt | Where-Object { $_.Trim() -and -not $_.StartsWith('#') } | ForEach-Object {
  $source, $skill = $_.Trim() -split '\s+', 2
  if (-not $groups.Contains($source)) { $groups[$source] = @() }
  $groups[$source] += $skill
}

$logs = Join-Path $env:TEMP 'claude-skills-logs'
New-Item -ItemType Directory -Force $logs | Out-Null

$i = 0
$procs = foreach ($source in $groups.Keys) {
  $i++
  $list = $groups[$source] -join ' '
  Write-Host "==> $source : $list"
  $p = Start-Process cmd.exe -ArgumentList "/c `"$skills`" add $source --skill $list -g -a claude-code -y" `
    -RedirectStandardOutput "$logs\$i.out" -RedirectStandardError "$logs\$i.err" -NoNewWindow -PassThru
  $p | Add-Member -NotePropertyName Source -NotePropertyValue $source -PassThru
}
$procs | Wait-Process
foreach ($p in $procs) { if ($p.ExitCode -ne 0) { Write-Warning "falló: $($p.Source) (logs en $logs)" } }

$missing = $groups.Values | ForEach-Object { $_ } |
  Where-Object { -not (Test-Path "$env:USERPROFILE\.claude\skills\$_\SKILL.md") }
if ($missing) { Write-Warning "faltan: $($missing -join ', ')" } else { Write-Host 'OK: todas las skills instaladas' }
