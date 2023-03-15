# INDI PROD

## DESCRIPTION
+ Software zuweisungokhoz statikus és DL-SWD csoportokon
+ DL-SWD zuweisungkor az -IsUserPolicyAllassociatedComputer paramétert módosítani kell!
+ 'Letükrözi' az adott csoportot a Prod szabályainak megfelelően


## SYNTAX

```ruby
indiprod [[-start] <String>] [[-revupdate] <Array>] [[-exc] <Array>] [[-dict] <Hashtable>] 
```

## EXAMPLES

```powershell
indiprod -start '22:00 01.31.2022' -revupdate @(6767,9852) -exc @(13215,15644) -dict @{15616 = 864641}

```

## PARAMETERS

### -start
policy aktiválódási időpontja

```yaml
Type: String
Mandatory: True
Syntax: '22:00 05.30.2023' --> 'HH:MM MM.DD.YYYY'
```

### -revupdate
Policy ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
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

pilot, qs és prod csoportok
```yaml
Type: Hashtable
Mandatory: True
Syntax:  @{current = target
           honnan = hova
         }
```