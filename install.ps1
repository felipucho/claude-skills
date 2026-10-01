# Instala todas las skills de skills.txt en ~\.claude (global).
Set-Location $PSScriptRoot
Get-Content skills.txt | Where-Object { $_.Trim() -and -not $_.StartsWith('#') } | ForEach-Object {
  $source, $skill = $_ -split '\s+', 2
  Write-Host "==> $skill  ($source)"
  npx -y skills add $source --skill $skill -g -a claude-code -y
  if ($LASTEXITCODE -ne 0) { Write-Warning "falló: $skill" }
}
