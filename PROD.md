# PROD

## DESCRIPTION
+ Software zuweisungokhoz kizárólag statikus, bázscsoportokon a release PROD szakaszában
+ Használható revzióemelésre, uninstallra, wellézésre, erweiterungra

## SYNTAX

```Ruby
prod [-start] <String> [[-basis] <Int32>] [[-welle] <Int32>] [[-uninstall_basis] <Array>] [[-erweiterung_basis] <Array>] 
 [[-revupdate_basis] <Array>] [[-erweiterung_welle] <Array>] [[-revupdate_welle] <Array>] [[-deny_welle] <Array>]  

```

## EXAMPLES

```powershell
prod -start '22:00 01.31.2022' -basis 16884 -uninstall_basis @(13215,15644) -revupdate_basis @(84644,12774)

prod -start '22:00 04.14.2023' -welle 15685 -erweiterung_welle @(16515,68465) -deny_welle @(84164,684633)
```

## PARAMETERS

### -start
policy aktiválódási időpontja

```yaml
Type: String
Mandatory: True
Syntax: '22:00 05.30.2023' --> 'HH:MM MM.DD.YYYY'
```

### -basis
DSM group object ID, célcsoport 
```yaml
Type: Int32
Mandatory: False
```
### -welle
DSM group object ID, célcsoport

RG1-RG2-RG3
```yaml
Type: Int32
Mandatory: False
```

### -uninstall_basis
báziscsoporton lévő policy ID

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
### -erweiterung_basis
pilot, qs csoporton lévő policy ID

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
### -revupdate_basis
báziscsoporton lévő policy ID

nem használható, ha az adott releaseben a szofver egy magasabb revziója már medjelent DSM-ben!
```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
### -erweiterung_welle
pilot, qs csoporton lévő policy ID

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
### -revupdate_welle
pilot, qs csoporton lévő policy ID

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
### -deny_welle
pilot, qs csoporton lévő policy ID

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
