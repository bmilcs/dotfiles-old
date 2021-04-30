``` bash
# fully

%c     full: Thu Mar  3 23:05:25 2005

%D     date: 04/30/21
%F     date: 2021-04-03
%x     date: 12/31/99

%r     time: 11:11:04 PM 
%X     time: 23:13:48 
%R     time: 18:56
%T     time: 18:56:02

# time

%H     01-24 (24 hour) 
%k      1-24 (24 hour,pad)
%I     01-12 (12 hour)
%l      1-12 (12 hour,pad) 

%M     01-60 (min) 
%S     00-60 (sec) 
%N     000000000-999999999 (nano) 

%p     AM/PM (UPPER)
%P     am/pm (lower)

# date

%a     Sun
%A     Sunday

%b     Jan
%h     Jan
%B     January

%d     01 (day)
%e      1 (day,pad)

%m     01-12 (mon) 
%y     21 (year)
%Y     2021 (year)
%u     DoW: 1-7 (1=monday)
%w     DoW: 0-6 (0=sunday)

%t     a tab
%n     \n newline
%%     literal %

%q     quarter: 1-4
%j     001-366 day of year: 001-366
%C     century: 20 (year-last2)
%V     ISO week number, with Monday as first day of week (01..53)
%s     seconds since 1970-01-01 00:00:00 UTC
%U     week number, 00-53 sunday 1st day of week
%W     week number, 03-53 monday 1st day of week
%z     timezone: +hhmm numeric time zone (e.g., -0400)
%:z    timezone: +hh:mm numeric time zone (e.g., -04:00)
%::z   timezone: +hh:mm:ss numeric time zone (e.g., -04:00:00)
%:::z  time zone: numeric -04, +05:30
%Z     time zone: alpha   EDT

By default, date pads numeric fields with zeroes.  
optional flags may follow '%':

%-.    (hyphen) no padding
%_.    (underscore) pad: spaces
%0.    (zero) pad: zeros
%+.    pad with zeros, and put '+' before future years with >4 digits
%^.    use upper case if possible use opposite case if possible
%g     last two digits of year of ISO week number (see %G)
%G     year of ISO week number (see %V); normally useful only with %V

--debug         annotate the parsed date, and warn about questionable usage to stderr
--rfc-3339=FMT  2006-08-14 02:34:56-06:00
-d              display time described by STRING, not 'now' (--date=)
-f              like --date; once for each line of DATEFILE (--file=)
-I[FMT]         2006-08-14T02:34:56-06:00 (--iso-8601[=FMT])
-R              Mon, 14 Aug 2006 02:34:56 -0600 (--rfc-email)
-r              display the last modification time of FILE (--reference=FILE)
-s              set time described by STRING (--set=STRING)
-u              print or set Coordinated Universal Time (UTC) (--utc, --universal)

# EXAMPLES

Convert seconds since the epoch (1970-01-01 UTC) to a date
$ date --date='@2147483647'

Show the time on the west coast of the US (use tzselect(1) to find TZ)
$ TZ='America/Los_Angeles' date

Show the local time for 9AM next Friday on the west coast of the US
$ date --date='TZ="America/Los_Angeles" 09:00 next Fri'

DATE STRING
       The --date=STRING is a mostly free format human readable date string such as "Sun, 29 Feb 2004 16:21:42 -0800" or  "2004-02-29  16:21:42"  or
       even "next Thursday".  A date string may contain items indicating calendar date, time of day, time zone, day of week, relative time, relative
       date, and numbers.  An empty string indicates the beginning of the day.  The date string format is more complex  than  is  easily  documented
       here but is fully described in the info documentation.
