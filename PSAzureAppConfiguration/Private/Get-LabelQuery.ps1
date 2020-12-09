function Get-LabelQuery {
    <#
        .SYNOPSIS
            Converts to label query
        .EXAMPLE
            Get-LabelQuery -Label \0
            Expected Output: '\0'
        .EXAMPLE
            Get-LabelQuery -Label Prod
            Expected Output: "'\0',Prod"
        .EXAMPLE
            Get-LabelQuery -Label *
            Expected Output: "*"
        .EXAMPLE
            Get-LabelQuery -Label ""
            Expected Output: "\0"
    #>
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