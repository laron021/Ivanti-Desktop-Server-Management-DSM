# REGEX

## DESCRIPTION
+ Reguláris kifejezéssel ellenőrzi a dátumformátumot

## SYNTAX

```ruby
regex [[-m] <String>] 
```

## EXAMPLES

```powershell
regex -m '22:00 11.03.2023'

```

# STANDARD

## DESCRIPTION
+ Standard zuweisunghoz konfig-system Umgebung beállítás nélkül

## SYNTAX

```ruby
standard [[-start] <String>] [[-target] <Int32>] [[-SwID] <Int32>] 
```

## EXAMPLES

```powershell
standard -start '22:00 03.30.2023' -target 55488 -SwID 68684

```

## PARAMETERS

### -start

```yaml
Type: String
Mandatory: True
Syntax: '22:00 05.30.2023' --> 'HH:MM MM.DD.YYYY'
```

### -target 

```yaml
Type: Int32
Mandatory: True
```

### -SwID 

```yaml
Type: Int32
Mandatory: True
```


# DENY

## DESCRIPTION
+ DENY zuweisunghoz 

## SYNTAX

```ruby
deny [[-start] <String>] [[-target] <Int32>] [[-SwID] <Int32>] 
```

## EXAMPLES

```powershell
deny -start '22:00 03.23.2023' -target 55488 -SwID 68684

```

## PARAMETERS

### -start

```yaml
Type: String
Mandatory: True
Syntax: '22:00 05.30.2023' --> 'HH:MM MM.DD.YYYY'
```

### -target 

```yaml
Type: Int32
Mandatory: True
```

### -SwID 

```yaml
Type: Int32
Mandatory: True
```
