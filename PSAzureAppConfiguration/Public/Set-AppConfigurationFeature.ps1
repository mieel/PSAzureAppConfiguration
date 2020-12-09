function Set-AppConfigurationFeature {
    <#
        .SYNOPSIS
            Lists features from an Azure App Configuration
            if state is not provided, it will toggle (on -> off, off -> on )
        .EXAMPLE
            $feature = Get-AppConfigurationFeature -Store $Store
            $feature = $feature | Set-AppConfigurationFeature
            $feature

            Togggle the feature on an off depending the current state
        .EXAMPLE
            Set-AppConfigurationFeature -State On -Feature $feature.key -Store $store -verbose

            Ensures a that state of a feature is On
    #>
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline)]
        [psobject] $FeatureObject
        ,
        [string] $Feature
        ,
        [string] $Store
        ,
        [string] $Label = '\0'
        ,
        [string] $State
    )
    process {
        if ( $PSBoundParameters.ContainsKey('FeatureObject') ) {
            Write-Verbose 'Using pipeline object'
            $Store = $FeatureObject.Store
            $Feature = $FeatureObject.key
            $Label = $FeatureObject.Label
            $currentFeatureState = $FeatureObject.State
        }
        if ( -not$Label ) {
            $Label = '\0'
            Write-Verbose $Label
        }
        if ( -not($currentFeatureState) -and -not($PSBoundParameters.ContainsKey('State')) ) {
            Write-Verbose 'State not set, current state unknown, getting current state pipeline object'
            $currentFeatureState = (Get-AppConfigurationFeature -Feature $Feature -Label $Label -Store $store).State
        }
        if ( -not($PSBoundParameters.ContainsKey('State')) ){
            $state = if ($currentFeatureState -eq 'off') { 'on' } else { 'off' }
        }
        $verbs = @{
            'on' = 'enable'
            'off' = 'disable'
        }
        $Result = Invoke-AzCli "appconfig feature $($verbs[$state]) --name $Store --label $Label --feature $Feature --yes"
        $Result | Add-Member -NotePropertyName Store -NotePropertyValue $Store
        Write-Output $Result
    }
    end {
    }
}