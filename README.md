# swift-constraints
Screwing around with visual constraints using swift operators. I think I've read about others writing this, but was just curious how it looked/worked. Needs a lot of cleanup before anyone ever uses it.

Lets you do things like:
Align a view horizontally to both edges of its superview:
```
|-label-|
```
Align a view vertically to both edges of its superview:
```
^-label-^
```
Align `label` 10 px from the leading edge of its superview, then a 20 pixel gap, then `view2`, aligned to the trailing edges of its superview:
```
|-20-label-10-label2-20-|
```
Align `label2` vertically to be have its top 20 pixels below `label`'s, and its bottom 20 pixels above `label`:
```
label.topAnchor-20-label2-20-label.bottomAnchor
```
Vertically, align `view` to have a height greater-than-or-equal-to 50 at a low priority, and a 50 pixel gap to the bottom of the screen (again, low priority), 
```
^-view/<=150~250-50~250-^
```
