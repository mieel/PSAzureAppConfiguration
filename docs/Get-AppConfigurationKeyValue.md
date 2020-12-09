---
external help file: PSAzureAppConfiguration-help.xml
Module Name: PSAzureAppConfiguration
online version:
schema: 2.0.0
---

# Get-AppConfigurationKeyValue

## SYNOPSIS
Gets (a) key value(s) from an Azure App Configuration Store
perform an az login first

## SYNTAX

```
Get-AppConfigurationKeyValue [[-Key] <String>] [-Store] <String> [[-Label] <String>] [-NoResolveSecret]
 [-ExcludeNoLabel] [-ConvertReferences] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-AppConfigurationKeyValue -Store $store
```

Gets all key values from $store

### EXAMPLE 2
```
Get-AppConfigurationKeyValue -Store $store -Key Common* -ConvertReferences
```

Gets all key values starting with 'Common' from $store
  and converts referenced keys

### EXAMPLE 3
```
Get-AppConfigurationKeyValue -Store $store -Label Development -NoResolveSecret
```

Gets all key values with labels null or Development from $store
does not resolve keyvault secrets

### EXAMPLE 4
```
Get-AppConfigurationKeyValue -Store $store -Key .appconfig.featureflag*
```

Gets all feature flags
You can also use Get-AppConfigurationFeature

## PARAMETERS

### -Key
{{ Fill Key Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -Store
{{ Fill Store Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
Position: 3
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoResolveSecret
{{ Fill NoResolveSecret Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeNoLabel
{{ Fill ExcludeNoLabel Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConvertReferences
{{ Fill ConvertReferences Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
