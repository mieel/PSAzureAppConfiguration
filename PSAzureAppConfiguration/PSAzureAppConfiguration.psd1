@{
    # The module version should be SemVer.org compatible
    ModuleVersion          = "0.0.1"

    # PrivateData is where all third-party metadata goes
    PrivateData            = @{
        # PrivateData.PSData is the PowerShell Gallery data
        PSData             = @{
            # Prerelease string should be here, so we can set it
            Prerelease     = 'local'

            # Release Notes have to be here, so we can update them
            ReleaseNotes   = ''

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags           = 'Configuration','Azure','Azure App Configuration'

            # A URL to the license for this module.
            LicenseUri     = 'https://github.com/mieel/PSAzureAppConfiguration/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri     = 'https://github.com/mieel/PSAzureAppConfiguration'

            # A URL to an icon representing this module.
            IconUri        = 'https://github.com/mieel/PSAzureAppConfiguration/blob/resources/PSAzureAppConfiguration.png?raw=true'
        } # End of PSData
    } # End of PrivateData

    # The main script module that is automatically loaded as part of this module
    RootModule             = 'PSAzureAppConfiguration.psm1'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules        = @()

    # Always define FunctionsToExport as an empty @() which will be replaced on build
    FunctionsToExport      = @()
    AliasesToExport        = @()

    # ID used to uniquely identify this module
    GUID                   = '0a181fbd-3208-4ab8-a2c3-120e65c09b7c'
    Description            = 'A module for data retrieval from Azure App Configuration'

    # Common stuff for all our modules:
    CompanyName            = 'Michiel Thai'
    Author                 = 'Michiel Thai'
    Copyright              = "Copyright 2020 Michiel Thai"

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion      = '5.1'
    CompatiblePSEditions = @('Core','Desktop')
}




