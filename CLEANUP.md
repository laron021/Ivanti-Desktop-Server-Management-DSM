# CLEANUP

## DESCRIPTION
+ IPN utáni fölöslegessé vált zuweisungok törlésésre a báziscsoportokból QSA-PILOT
+ Az erweiterunggal Prodba került policy-k targetjeit uninstall nélkül eltávolítja kivéve magát a bázis csoportot 
+ Ha nem kezeljük kivételként, a Jobpolicy-k is törlésre kerülnek!

## SYNTAX

```ruby
cleanup [[-getpolicy] <Int32>] [[-basisgroup] <Int32>] [[-exc] <Array>]
```

## EXAMPLES

```powershell
cleanup -getpolicy 87646 -basisgroup 15644 -exc @(32544,68768)

```

## PARAMETERS

### -getpolicy
DSM group object ID

```yaml
Type: Int32
Mandatory: True
```

### -basisgroup
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
