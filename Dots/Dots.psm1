#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$ModuleRoot = $PSScriptRoot
$ScriptsPath = (Resolve-Path "$ModuleRoot\IngestionScripts").Path
$AutoPath = (Resolve-Path "$ScriptsPath\Auto").Path
$ManualPath = (Resolve-Path "$ScriptsPath\Manual").Path
$ConfPath = (Resolve-Path "$ModuleRoot\Conf").Path
$DataPath = (Resolve-Path "$ModuleRoot\Data").Path

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        Write-Host "Importing $($Import.FullName)"
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename