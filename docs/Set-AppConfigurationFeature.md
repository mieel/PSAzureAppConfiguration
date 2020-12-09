---
external help file: PSAzureAppConfiguration-help.xml
Module Name: PSAzureAppConfiguration
online version:
schema: 2.0.0
---

# Set-AppConfigurationFeature

## SYNOPSIS
Lists features from an Azure App Configuration
if state is not provided, it will toggle (on -\> off, off -\> on )

## SYNTAX

```
Set-AppConfigurationFeature [[-FeatureObject] <PSObject>] [[-Feature] <String>] [[-Store] <String>]
 [[-Label] <String>] [[-State] <String>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
$feature = Get-AppConfigurationFeature -Store $Store
$feature = $feature | Set-AppConfigurationFeature
$feature
```

## PARAMETERS

### -FeatureObject
{{ Fill FeatureObject Description }}

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Feature
{{ Fill Feature Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Store
{{ Fill Store Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label
{{ Fill Label Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: \0
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
{{ Fill State Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
