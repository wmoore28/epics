      subroutine read_db(ldown)
      implicit none
      character*100 pvname, filename, line
      character*20 label_in
      integer*4 lenpv, i_status, icounter, istat
      logical*4 lloop, ldown
      real*8 set_v, mvdz, mcdz, ramp_up, ramp_down, trip_current,
     &  v_limit
      include 'hv.inc'
      print *, ' input hv data file name'
      read 10, filename
 10   format (a100)
      open (unit = 20, file = filename, status = 'old')
      lloop = .true.
      nchan_hv = 0
      call group_on(i_status)
      if (i_status .ne. 0)
     &  stop 'read_db: stopping bad status from group_on'
      icounter = 0
      do while (lloop)
        read (20, *, iostat = istat) label_in
        if (istat .ne. 0) then
          lloop = .false.
        else
          backspace 20
          nchan_hv = nchan_hv + 1
          read (20, 5000) line
 5000     format (a100)
          call parse (line, label_hv(nchan_hv), group_hv(nchan_hv),
     &      enable_hv(nchan_hv),
     &      ioc_hv(nchan_hv),
     &      mf_hv(nchan_hv),
     &      card_hv(nchan_hv), submod_hv(nchan_hv), chan_hv(nchan_hv),
     &      set_v, mvdz, mcdz,
     &      ramp_up, ramp_down, trip_current, v_limit)
          print *, label_hv(nchan_hv), group_hv(nchan_hv),
     &      enable_hv(nchan_hv),
     &      ioc_hv(nchan_hv),
     &      mf_hv(nchan_hv),
     &      card_hv(nchan_hv), submod_hv(nchan_hv), chan_hv(nchan_hv),
     &      set_v, mvdz, mcdz,
     &      ramp_up, ramp_down, trip_current, v_limit
          call get_pvname(nchan_hv, pvname, lenpv)
          print *, pvname(1:lenpv)
          if (ldown) then
            call write_enable(nchan_hv, 0)
            call write_set_v(nchan_hv, set_v)
            call write_mvdz(nchan_hv, mvdz)
            call write_mcdz(nchan_hv, mcdz)
            call write_ramp_up(nchan_hv, ramp_up)
            call write_ramp_down(nchan_hv, ramp_down)
            call write_trip_current(nchan_hv, trip_current)
            call write_alarms(nchan_hv)
            icounter = icounter + 1
            if (icounter .eq. 1) then
              call group_off(i_status)
              call group_on(i_status)
              icounter = 0
            end if
          end if
        end if
      end do
      call group_off(i_status)
      if (i_status .ne. 0) print *,'read_db: stopping bad status from ',
     &  'group_off, i_status = ', i_status
      close (unit = 20)
      return
      end
