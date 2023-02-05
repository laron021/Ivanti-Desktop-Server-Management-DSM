# PROD

## DESCRIPTION
+ Software zuweisungokhoz kizárólag statikus, bázscsoportokon a release PROD szakaszában
+ Használható revzióemelésre, uninstallra, wellézésre, erweiterungra

## SYNTAX

```
prod [-start] <String> [[-basis] <Int32>] [[-welle] <Int32>] [[-uninstall_basis] <Array>] [[-erweiterung_basis] <Array>] 
 [[-revupdate_basis] <Array>] [[-erweiterung_welle] <Array>] [[-revupdate_welle] <Array>] [[-deny_welle] <Array>]  

```

## EXAMPLES

```
pilot -start '22:00 30.01.2022' -currentgroup 16884 -targetgroup 19875 -exc @(13215,15644)
```

## PARAMETERS

### -start
'22:00 30.05.2023' --> 'HH:MM DD.MM.YYYY'

```yaml
Type: String
Mandatory: True
```

### -targetgroup
DSM group object ID

```yaml
Type: Int32
Mandatory: True
```
### -currentgroup
DSM group object ID

```yaml
Type: Int32
Mandatory: True
```

### -exc
Policy ID --> @(3333,4444)

```yaml
Type: Array
Mandatory: False
```
