# PILOT

## DESCRIPTION
+ Software zuweisungokhoz kizárólag statikus, bázscsoportokon a release PILOT szakaszában
+ Kezeli a system-konfig beállítással rendelkező policykat is, ezek inactive státuszt kapnak
+ A kivételkezeléstől eltekintve új célcsoportot ad a policyknak(erweiterung)

## SYNTAX

```
pilot [-start] <String> [[-targetgroup] <Int32>] [[-currentgroup] <Int32>] [[-exc] <Array>] 
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
Software ID --> @(3333,4444)

```yaml
Type: Array
Mandatory: False
```
