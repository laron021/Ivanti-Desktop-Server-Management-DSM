# PowerShell scripts for Ivanti DSM


---
Module Name: DSMScript.psm1
** txh for uwefranke **
---

# 

## DESCRIPTION(https://www.youtube.com/)
Fuegt eine Policy einem Object zu.

## SYNTAX

```
Add-DSM7PolicyToTarget [-ID] <Int32> [[-TargetID] <Int32>] [[-TargetName] <String>]
 [[-TargetLDAPPath] <String>] [[-TargetParentContID] <String>] [<CommonParameters>]
```

## DESCRIPTION
Fuegt eine Policy einem Object zu.

## EXAMPLES

### BEISPIEL 1
```
Add-DSM7PolicyToTarget -ID 1234 -TargetName "Ziel" -TargetLDAPPath "Managed Users & Computers/OU1"
```

### BEISPIEL 2
```
Add-DSM7PolicyToTarget -ID 1234 -TargetID 1234
```

## PARAMETERS

### -ID
{{Fill ID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetID
{{Fill TargetID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetName
{{Fill TargetName Description}}

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

### -TargetLDAPPath
{{Fill TargetLDAPPath Description}}

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

### -TargetParentContID
{{Fill TargetParentContID Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS


