# PowerShell scripts for Ivanti DSM


---
Module Name: DSMScript.psm1 * txh for [uwefranke](https://github.com/uwefranke/msgDSM7Module) *
---

# 

## FUNCTIONS 
[QSA](https://github.com/laron021/IT/blob/main/QSA.md)

## DESCRIPTION


## SYNTAX

```
Add-DSM7PolicyToTarget [-ID] <Int32> [[-TargetID] <Int32>] [[-TargetName] <String>]
 [[-TargetLDAPPath] <String>] [[-TargetParentContID] <String>] [<CommonParameters>]
```

## DESCRIPTION
Fuegt eine Policy einem Object zu.

## EXAMPLES

### BEISPIEL 1
```
Add-DSM7PolicyToTarget -ID 1234 -TargetName "Ziel" -TargetLDAPPath "Managed Users & Computers/OU1"
```

### BEISPIEL 2
```
Add-DSM7PolicyToTarget -ID 1234 -TargetID 1234
```

1. First ordered list item
2. Another item
⋅⋅* Unordered sub-list. 
1. Actual numbers don't matter, just that it's a number
⋅⋅1. Ordered sub-list
4. And another item.

⋅⋅⋅You can have properly indented paragraphs within list items. Notice the blank line above, and the leading spaces (at least one, but we'll use three here to also align the raw Markdown).

⋅⋅⋅To have a line break without a paragraph, you will need to use two trailing spaces.⋅⋅
⋅⋅⋅Note that this line is separate, but within the same paragraph.⋅⋅
⋅⋅⋅(This is contrary to the typical GFM line break behaviour, where trailing spaces are not required.)

* Unordered list can use asterisks
- Or minuses
+ Or pluses



## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS


