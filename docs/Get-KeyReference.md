---
external help file: PSAzureAppConfiguration-help.xml
Module Name: PSAzureAppConfiguration
online version:
schema: 2.0.0
---

# Get-KeyReference

## SYNOPSIS
Parses a string and extracts the tokenized strings
Default prefix and suffix is '$(' and ')'
Only words chars and dots are allowed as key strings

## SYNTAX

```
Get-KeyReference [[-String] <String>] [[-regex] <String>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-KeyReference -String 'MyServer=$(MyApp.Database.Server);Database=$(MyApp.Database.Name);Trusted_Connection=Yes'
Expected Output: @('MyApp.Database.Server','MyApp.Database.Name')
```

### EXAMPLE 2
```
$string = '$(MyDomain)\$(MyUserName)_$(Environment)'
Get-KeyReference -String $string
Expected Output: @('MyDomain','MyUserName','Environment')
```

## PARAMETERS

### -String
{{ Fill String Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -regex
{{ Fill regex Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: \$\([\w.]*\)
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
