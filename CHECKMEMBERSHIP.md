# CHECKMEMBRSHIP

## DESCRIPTION
+ IPN utáni fölöslegessé vált zuweisungok törlésésre 
+ Ha egy Individuell szoftver kikerült egy DL-SWD csoportra, akkor a tesztcsoportokon maradt policy-k adott feltételek mellett törölhetőek. Ha egy tesztcsoportban lévő user tagja az adott szoftver DL-SWD csoportjának, nem csükséges a policy-t uninstallálálni. Amenniaben viszont nem tagja, törlésre kerül sor. 
+ A script azt vizsgálja, hogy a gépre legutolsóként bejelentkezett user rendelkezik-e csoporttagsággal az adott szoftver DL-SWD csoportjában

## SYNTAX

```ruby
checkmembership [[-groups] <Array>]
```

## EXAMPLES

```powershell
checkmembership -groups @(32544,68768)

```

## PARAMETERS

### -groups
DSM Group object ID 

```yaml
Type: Array
Mandatory: False
Syntax:  @(3333,4444)
```
