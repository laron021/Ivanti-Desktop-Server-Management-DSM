# QSA

## DESCRIPTION
+ Software zuweisungokhoz kizárólag statikus, bázscsoportokon a release QSA szakaszában
+ Kizárólag olyan zuweisungra használható, ahol az adott szoftver install paraméterei nem tartlamaznak system-konfig umgebung beálltásokat


## SYNTAX

```html
qsa [[-start] <String>] [[-targetgroup] <Int32>] [[-standard] <Array>] [[-revupdate] <Array>] [[-deny] <Array>]
```

## EXAMPLES

```powershell
qsa -start '22:00 30.01.2022' -targetgroup 19875 -standard @(13215,15644) -deny @(32544,68768)

qsa -start '22:00 17.05.2023' -targetgroup 17468 -revupdate @(87463,24813)
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

### -standard
Software ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```

### -deny
Software ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```

### -revupdate
Software ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
