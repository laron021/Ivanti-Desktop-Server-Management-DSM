# WELLE

## DESCRIPTION
+ Software zuweisungokhoz, ha IPN után a szoftwerek különböző hullámban kerülnek kioszásra, aktiválásra


## SYNTAX

```ruby
welle [[-start] <String>] [[-targetwelle] <Int32>] [[-currentwelle] <Int32>] [[-exc] <Array>]
```

## EXAMPLES

```powershell
welle -start '22:00 30.01.2022' -targetwelle 19875 -currentwelle 13215 -exc @(32544,68768)

```

## PARAMETERS

### -start
policy aktiválódási időpontja

```yaml
Type: String
Mandatory: True
Syntax: '22:00 30.05.2023' --> 'HH:MM DD.MM.YYYY'
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

### -exc
Policy ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
