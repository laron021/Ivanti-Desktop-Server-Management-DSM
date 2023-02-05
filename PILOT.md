# PILOT

## DESCRIPTION
+ Software zuweisungokhoz kizárólag statikus, bázscsoportokon a release PILOT szakaszában
+ Kezeli a system-konfig beállítással rendelkező policykat is, ezek inactive státuszt kapnak
+ A kivételkezeléstől eltekintve új célcsoportot ad a policyknak(erweiterung)

## SYNTAX

```Ruby
pilot [-start] <String> [[-targetgroup] <Int32>] [[-currentgroup] <Int32>] [[-exc] <Array>] 
```

## EXAMPLES

```powershell
pilot -start '22:00 30.01.2022' -currentgroup 16884 -targetgroup 19875 -exc @(13215,15644)
```

## PARAMETERS

### -start
policy aktiválódási időpontja

```yaml
Type: String
Mandatory: True
Syntax: '22:00 30.05.2023' --> 'HH:MM DD.MM.YYYY'
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
Policy ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
