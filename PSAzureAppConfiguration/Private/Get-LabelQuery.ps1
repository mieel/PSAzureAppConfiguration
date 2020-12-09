function Get-LabelQuery {
    <##>
    param(
        [string] $Label
        ,
        [switch] $ExcludeNoLabel
    )
    if (-not($Label) -or $Label -eq '\0' ){
        Return '\0'
    }
    if ( $PSBoundParameters.Label -eq '*') {
        Return '*'
    }
    if ( $PSBoundParameters.ExcludeNoLabel ) {
        Return $Label
    }
    Return "\0,$Label"
}