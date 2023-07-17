# PILOT

## DESCRIPTION
...

## SYNTAX

```Ruby
pilot [-start] <String> [[-targetgroup] <Int32>] [[-currentgroup] <Int32>] [[-exc] <Array>] 
```

## EXAMPLES

```powershell
pilot -start '22:00 01.31.2022' -currentgroup 16884 -targetgroup 19875 -exc @(13215,15644)
```

```powershell
pilot -start $start -currentgroup 16884 -targetgroup 19875 -exc @(13215,15644)
```

## PARAMETERS

### -start
policy activation start date

```yaml
Type: String
Mandatory: True
Syntax: '22:00 05.30.2023' --> 'HH:MM MM.DD.YYYY'
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
