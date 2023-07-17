# INDI PILOT

## DESCRIPTION
...


## SYNTAX

```ruby
indipilot [[-start] <String>] [[-exc] <Array>] [[-dict] <Hashtable>] 
```

## EXAMPLES

```powershell
indipilot -dict @{450706=450705} -start "22:00 04.04.2023" -exc @(13215,15644)
```

```powershell
indipilot -dict @{450706=450705} -start $start -exc @(13215,15644)
```

## PARAMETERS

### -start
policy activation start date

```yaml
Type: String
Mandatory: True
Syntax: '22:00 05.30.2023' --> 'HH:MM MM.DD.YYYY'
```

### -exc
Policy ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
### -dict
DSM Group object ID

pilot, qs and prod group ID 
```yaml
Type: Hashtable
Mandatory: True
Syntax:  @{current = target
           honnan = hova
         }
```
