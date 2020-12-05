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
            Tags           = 'Authoring','Build','Development'

            # A URL to the license for this module.
            LicenseUri     = 'https://github.com/mieel/plumber/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri     = 'https://github.com/mieel/plumber'

            # A URL to an icon representing this module.
            IconUri        = 'https://github.com/mieel/plumber/blob/resources/plumber.png?raw=true'
        } # End of PSData
    } # End of PrivateData

    # The main script module that is automatically loaded as part of this module
    RootModule             = 'Plumber.psm1'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules        = @()

    # Always define FunctionsToExport as an empty @() which will be replaced on build
    FunctionsToExport      = @()
    AliasesToExport        = @()

    # ID used to uniquely identify this module
    GUID                   = '8a4f5d47-eecb-496b-a6bb-9a06e7cc5772'
    Description            = 'A module for building and maintaining Pipelines'

    # Common stuff for all our modules:
    CompanyName            = 'Michiel Thai'
    Author                 = 'Michiel Thai'
    Copyright              = "Copyright 2020 Michiel Thai"

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion      = '5.1'
    CompatiblePSEditions = @('Core','Desktop')
}




