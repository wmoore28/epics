      program hv
      implicit none
      include 'hv.inc'
      character*1 command
      integer*4 mfno, igrno, ipage, npages
      logical*4 lloop
      lloop = .true.
      do while (lloop)
        print *, 'enter command (h for help)'
        read 100, command
 100    format (a1)
        if (command .eq. 'h') then
          print 200
 200      format ('valid commands are: ',/,
     &      ' i Initialize: read file and download',/,
     &      ' r Read file, no downloading',/,
     &      ' n mainframe oN',/,
     &      ' f mainframe ofF',/,
     &      ' m show measured values',/,
     &      ' e Enable hv for a group',/,
     &      ' d Disable hv for a group',/,
     &      ' s show control Settings',/,
     &      ' o control One channel',/,
     &      ' w write a data file using mainframe values',/,
     &      ' q Quit')
        else if (command .eq. 'i') then
          call read_db(.true.)
        else if (command .eq. 'r') then
          call read_db(.false.)
        else if (command .eq. 'n') then
          print *, 'enter mainframe number'
          read *, mfno
          call mf_on(mfno)
        else if (command .eq. 'f') then
          print *, 'enter mainframe number'
          read *, mfno
          call mf_off(mfno)
        else if (command .eq. 'm') then
          npages = nchan_hv/20 + 1
          print *, 'total pages = ', npages, ' enter page number'
          read *, ipage
          call print_channels(ipage)
        else if (command .eq. 'q') then
          lloop = .false.
        else if (command .eq. 'e') then
          print *, 'enter group number'
          read *, igrno
          call ramp_up_group(igrno)
        else if (command .eq. 'd') then
          print *, 'enter group number'
          read *, igrno
          call ramp_down_group(igrno)
        else if (command .eq. 's') then
          npages = nchan_hv/20 + 1
          print *, 'enter page number (there are ', npages , ' pages)' 
          read *, ipage
          call show_settings(ipage)
        else if (command .eq. 'o') then
          call single_channel
        else if (command .eq. 'w') then
          call make_dat
        else
          print *, 'invalid command'
        end if
      end do
      stop
      end

