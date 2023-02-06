# WELLE

## DESCRIPTION
+ Software zuweisungokhoz, ha IPN után a szoftwerek különböző hullámban kerülnek kioszásra, aktiválásra


## SYNTAX

```ruby
welle [[-start] <String>] [[-targetwelle] <Int32>] [[-currentwelle] <Int32>] [[-exc] <Array>] [[-final] <Int32>]
```

## EXAMPLES

```powershell
welle -start '22:00 01.31.2022' -targetwelle 19875 -currentwelle 13215 -exc @(32544,68768)

welle -start '22:00 01.31.2022' -targetwelle 19875 -currentwelle 13215 -final 19875

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

Az utolsó wellében, ami a báziscsoport kötelező megadni. Ugyanis itt nem kerül DenyPolicy létrehozásra, hanem a  már meglévő Policy fog uninstallra kerülni.
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
