# CREATEGROUP

## DESCRIPTION
+ Statikus csoportok létrehozása gépek számára és adott esetben a kívánt tesztgépek hozzáadása a csoporthoz

## SYNTAX

```ruby
creategroup [[-groupname] <String>] [[-testers] <Array>]
```

## EXAMPLES

```powershell
creategroup -groupname '_Test_zuweisung' -testers @('BPC12','BPC13')

```

## PARAMETERS

### -groupname

```yaml
Type: String
Mandatory: True
```

### -testers 

```yaml
Type: String
Mandatory: False
Syntax:  @('Str','Str')
```
