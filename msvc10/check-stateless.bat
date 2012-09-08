@ECHO OFF
REM Complete check of a stateless encoding.
REM Usage: check-stateless.bat SRCDIR CHARSET

SET fname=%2
SET fname=%fname::=-%

.\table-from %2 > tmp-%fname%.TXT
.\table-to %2 | sort > tmp-%fname%.INVERSE.TXT
fc %1\%fname%.TXT tmp-%fname%.TXT

if not exist %1\%fname%.IRREVERSIBLE.TXT goto ELSE_1
  copy /B %1\%fname%.TXT /B + %1\%fname%.IRREVERSIBLE.TXT /B tmp
  sort < tmp | uniq-u > tmp-orig-%fname%.INVERSE.TXT
  fc tmp-orig-%fname%.INVERSE.TXT tmp-%fname%.INVERSE.TXT
  REM del tmp
  REM del tmp-orig-%fname%.INVERSE.TXT
  goto ENDIF_1
:ELSE_1
  sort < %1\%fname%.TXT | uniq-u > tmp-orig-%fname%.INVERSE.TXT
  fc tmp-orig-%fname%.INVERSE.TXT tmp-%fname%.INVERSE.TXT
  REM del tmp-orig-%fname%.INVERSE.TXT
:ENDIF_1

REM del tmp-%fname%.TXT
REM del tmp-%fname%.INVERSE.TXT
