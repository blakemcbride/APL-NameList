⍝!

⍝ Package:    Name List Functions
⍝ Author:     David Lamkins
⍝ Email:      david@lamkins.net
⍝ Date:       2014-07-11
⍝ License:    MIT License
⍝ Platform:   GNU APL
⍝ Bug Report: https://lists.gnu.org/mailman/listinfo/bug-apl
⍝ Prefix:     nlf

⍝ Utility library for GNU APL defines ]nlf command to list workspace
⍝ names.
⍝
⍝ For example:
⍝       ]nlf i aei             Lists all names containing any of the 
⍝                              characters a, e or i.
⍝       ]nlf e qux             Lists only names containing none of
⍝                              the characters q, u or x.
⍝       ]nlf i _∆ 2            Lists only variable names (name class
⍝                              2) containing either of the characters
⍝                              _ or ∆.
⍝       ]nlf e ⍙ 3 4           Lists only function and operator names
⍝                              (name classes 3 and 4, respectively)
⍝                              not containing the character ⍙.
⍝       ]nlf ?                 Displays brief instructions.

∇z←⍙⍙⍙class nlf_ni ⍙⍙⍙set
  ⍝ Return a character array of every workspace name which includes
  ⍝ all characters in ⍙⍙⍙set. The empty set matches everything. The
  ⍝ optional ⍙⍙⍙class argument selects results by name class; the
  ⍝ default is 2 3 4 (variables, functions and operators).
  ⍎(0=⎕nc '⍙⍙⍙class')/'⍙⍙⍙class←2 3 4'
  z←⊃{ (∧/⊃(⊂,⍙⍙⍙set)∊¨⍵)/⍵ }{ (∧\' '≠⍵)/⍵ }¨⊂[(1+⎕io)]⎕nl ⍙⍙⍙class
∇

∇z←⍙⍙⍙class nlf_ne ⍙⍙⍙set
  ⍝ Return a character array of every workspace name which excludes
  ⍝ any character in ⍙⍙⍙set. The empty set excludes nothing. The
  ⍝ optional ⍙⍙⍙class argument selects results by name class; the
  ⍝ default is 2 3 4 (variables, functions and operators).
  ⍎(0=⎕nc '⍙⍙⍙class')/'⍙⍙⍙class←2 3 4'
  z←⊃{ (~∨/⊃(⊂,⍙⍙⍙set)∊¨⍵)/⍵ }{ (∧\' '≠⍵)/⍵ }¨⊂[(1+⎕io)]⎕nl ⍙⍙⍙class
∇

∇⍙⍙⍙args nlf_ucmd ⍙⍙⍙line
  ⍝ Parse ]usercmd arguments and either display help or invoke one of
  ⍝ the listing functions.
  →(']nlf'≡⍙⍙⍙args)/help
  →(3>⍴⍙⍙⍙args)/help
  →(4>⍴⍙⍙⍙args)/disp
  →(~∨/4=(,¨'234')⍳3↓⍙⍙⍙args)/disp
  'class must be in 2 3 4'
  →help
disp:
  →('ie'∊↑1↓⍙⍙⍙args)/inc,exc
help:
  ((∧\' '≠⍙⍙⍙line)/⍙⍙⍙line),' i|e set [class ...]'
  'For more info: ',((∧\' '≠⍙⍙⍙line)/⍙⍙⍙line),' ?'
  →('?'≠↑1↓⍙⍙⍙args)/0
  'Display workspace names'
  '  i: show names having all characters in set'
  '  e: show names having only characters not in set'
  '  set: any of a-z, A-Z, 0-9, ∆⍙_¯'
  '  class: selects name class(es)'
  '    2: variables; 3: functions; 4: operators'
  →0
inc:
  →(3<⍴⍙⍙⍙args)/iwc
  nlf_ni ↑2↓⍙⍙⍙args
  →0
iwc:
  (⍎¨3↓⍙⍙⍙args) nlf_ni ↑2↓⍙⍙⍙args
  →0
exc:
  →(3<⍴⍙⍙⍙args)/ewc
  nlf_ne ↑2↓⍙⍙⍙args
  →0
ewc:
  (⍎¨3↓⍙⍙⍙args) nlf_ne ↑2↓⍙⍙⍙args
∇

⍝ Define the ]nlf ]usercmd.
]usercmd ]nlf nlf_ucmd 1
