# TOTALCLEANUP

## DESCRIPTION
+ IPN utáni fölöslegessé vált zuweisungok törlésésre a báziscsoportokból QSA-PILOT
+ Ha nem kezeljük kivételként, a Jobpolicy-k is törlésre kerülnek!
+ Kizárólag a CLEANUP után használható!!!


## SYNTAX

```ruby
qsa [[-start] <String>] [[-targetgroup] <Int32>] [[-standard] <Array>] [[-revupdate] <Array>] [[-deny] <Array>]
```

## EXAMPLES

```powershell
totalcleanup -exc @(156165,53899)
```

## PARAMETERS

### -exc
Policy ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
