      subroutine single_channel
      implicit none
      include 'hv.inc'
      character*1 command
      integer*4 channel
      integer*2 ienable
      logical*4 lloop
      real*8 ddum
      print *, 'enter channel number'
      read *, channel
      lloop = .true.
      do while (lloop)
        call single_info(channel)
        print *, 'enter single channel command (h for help)'
        read 100, command
 100    format (a1)
        if (command .eq. 'h') then
          print 200
 200      format ('valid commands are: ',/,
     &      ' s change set Voltage',/,
     &      ' u change ramp up rate',/,
     &      ' d change ramp down rate',/,
     &      ' i change trip current',/,
     &      ' v change mvdz',/,
     &      ' c change mcdz',/,
     &      ' e enable channel',/,
     &      ' o disable channel (off)',/,
     &      ' a change alarms',/,
     &      ' q Quit')
        else if (command .eq. 's') then
          print *, 'enter voltage (V)'
          read *, ddum
          call write_set_v(channel, ddum)
        else if (command .eq. 'u') then
          print *, 'enter ramp up rate (V/s)'
          read *, ddum
          call write_ramp_up(channel, ddum)
        else if (command .eq. 'd') then
          print *, 'enter ramp up rate (V/s)'
          read *, ddum
          call write_ramp_down(channel, ddum)
        else if (command .eq. 'i') then
          print *, 'enter trip current (uA)'
          read *, ddum
          call write_trip_current(channel, ddum)
        else if (command .eq. 'v') then
          print *, 'enter measured voltage dead zone (V)'
          read *, ddum
          call write_mvdz(channel, ddum)
        else if (command .eq. 'c') then
          print *, 'enter measured current dead zone (uA)'
          read *, ddum
          call write_mcdz(channel, ddum)
        else if (command .eq. 'e') then
          ienable = 1
          call write_enable(channel, ienable)
        else if (command .eq. 'o') then
          ienable = 0
          call write_enable(channel, ienable)
        else if (command .eq. 'a') then
          call change_alarms(channel)
        else if (command .eq. 'q') then
          lloop = .false.
        else if (command .ne. ' ') then
          print *, 'invalid command'
        end if
      end do
      return
      end

