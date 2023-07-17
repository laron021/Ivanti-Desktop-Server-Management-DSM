# CREATEGROUP

## DESCRIPTION
...

## SYNTAX

```ruby
creategroup [[-groupname] <String>] [[-testers] <Array>]
```

## EXAMPLES

```powershell
creategroup -groupname '_Testzuweisung' -testers @('BPC12','BPC13','BPC14')

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
