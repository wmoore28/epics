      subroutine change_alarms(channel)
      implicit none
      character*100 pvname
      character*4 value_field(4, 3)/'HHMV', 'HIMV', 'LOMV', 'LLMV',
     &                              'HHMC', 'HIMC', 'LOMC', 'LLMC',
     &                              'HHST', 'HIST', 'LOST', 'LLST'/,
     &         severity_field(4, 3)/'HHSV', 'HSMV', 'LSMV', 'LLSV',
     &                              'HHSC', 'HSMC', 'LSMC', 'LLSC',
     &                              'HHSS', 'HSST', 'LSST', 'LLSS'/
      integer*4 channel, itype, irange, isevere, lenpv, iret_code
      real*4 value
      logical lloop
c
      lloop = .true.
      do while (lloop)
        print *, ' enter type of alarm to set: 0=quit, 1=voltage, ',
     &    '2=current, 3=status '
        read *, itype
        if (itype .eq. 0) then
          lloop = .false.
        else
          print *, ' enter alarm range: 1=hihi, 2=hi, 3=lo, 4=lolo'
          read *, irange
          if (irange .lt. 1 .or. irange .gt. 4) then
            print *, ' invalid range, start over'
          else
            print *, ' enter severity: 0=no_alarm, 1=minor, 2=major'
            read *, isevere
            if (isevere .lt. 1 .or. isevere .gt. 3) then
              print *, ' invalid severity, start over'
            else
              call get_pvname(channel, pvname, lenpv)
              print *, ' enter numerical value for alarm'
              read *, value
              call p_value(pvname(1:lenpv)//'.'//value_field(irange,
     &          itype), 'float', value, 1, iret_code)
              if (iret_code .ne. 0) print *, ' return code from put',
     &          iret_code
              call p_value(pvname(1:lenpv)//'.'//severity_field(irange,
     &          itype), 'long', isevere, 1, iret_code)
              if (iret_code .ne. 0) print *, ' return code from put',
     &          iret_code
            end if
          end if
        end if
      end do
      return
      end
