# WELLE

## DESCRIPTION
...


## SYNTAX

```ruby
welle [[-start] <String>] [[-targetwelle] <Int32>] [[-currentwelle] <Int32>] [[-exc] <Array>] [[-final] <Int32>]
```

## EXAMPLES

```powershell
welle -start '22:00 01.31.2022' -targetwelle 19875 -currentwelle 13215 -exc @(32544,68768)
```

```powershell
welle -start $start -targetwelle 19875 -currentwelle 13215 -final 19875
```

## PARAMETERS

### -start
policy aktiválódási időpontja

```yaml
Type: String
Mandatory: True
Syntax: '22:00 05.30.2023' --> 'HH:MM MM.DD.YYYY'
```

### -targetwelle
DSM group object ID

```yaml
Type: Int32
Mandatory: True
```
### -currentwelle
DSM group object ID

```yaml
Type: Int32
Mandatory: True
```
### -final
DSM group object ID

MUST SET parameter in the last(4) rollout phase of Prod
```yaml
Type: Int32
Mandatory: False
```

### -exc
Policy ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
