# QSA

## DESCRIPTION
+ Software zuweisungokhoz kizárólag statikus, bázscsoportokon a release QSA szakaszában
+ Csak olyan zuweisungra használható, ahol az adott szoftver nem tartalmaz system-konfig installációs parméter beállításokat

## SYNTAX

```
qsa [-start] <String> [[-targetgroup] <Int32>] [[-standard] <Array>] [[-revupdate] <Array>] [[-deny] <Array>]
```

## EXAMPLES

```
qsa -start $activationstartdate -targetgroup 19875 -standard @(157866,15138) -deny @(84968,54756)
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
### -standard
Software ID --> @(1111,2222)

```yaml
Type: Array
Mandatory: False
```
### -revupdate
Software ID --> @(3333,4444)

```yaml
Type: Array
Mandatory: False
```
### -deny
Software ID --> @(5555,6666)

```yaml
Type: Array
Mandatory: False
```
