---
external help file: PSAzureAppConfiguration-help.xml
Module Name: PSAzureAppConfiguration
online version:
schema: 2.0.0
---

# Convert-KeyReference

## SYNOPSIS
Converts Keyreferences in a string with values retrieved from a given dictionary

## SYNTAX

```
Convert-KeyReference [[-String] <String>] [[-Dictionary] <Object>] [[-Prefix] <String>] [[-Suffix] <String>]
 [[-Cycle] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
$dict = @(
    @{
        Key = "MyDomain"
        Value = "Contoso"
    },
    @{
        Key = "MyUserName"
        Value = "Bob"
    },
    @{
        Key = "Environment"
        Value = "Production"
    }
)
$string = '$(MyDomain)\$(MyUserName)_$(Environment)'
Convert-KeyReference -String $string -Dictionary $dict
```

Expected Output: "Contoso\Bob_Production"

### EXAMPLE 2
```
$dict = @(
    @{
        Key = "Server"
        Value = "prod-001"
    },
    @{
        Key = "Database"
        Value = "RetailStore"
    },
    @{
        Key = "Trusted_Connection"
        Value = "yes"
    },
    @{
        Key = "ConnectionString"
        Value = 'Server=$(Server);Database=$(Database);Trusted_Connection=$(Trusted_Connection)'
    }
)
$string = 'ConnectionString=$(ConnectionString)'
Convert-KeyReference -String $string -Dictionary $dict
Expected Output: "ConnectionString=Server=prod-001;Database=RetailStore;Trusted_Connection=yes"
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

### -Dictionary
{{ Fill Dictionary Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix
{{ Fill Prefix Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: \$\(
Accept pipeline input: False
Accept wildcard characters: False
```

### -Suffix
{{ Fill Suffix Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: \)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cycle
{{ Fill Cycle Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
