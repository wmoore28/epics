      subroutine single_info(ich)
      implicit none
      include 'hv.inc'
      character*100 pvname
      integer*4 ich, iret_code, lenpv
      integer*2 enable, status
      real*8 v_set, v_meas, i_meas
      real*8 mvdz, mcdz, ramp_up, ramp_down, trip_current
      call get_pvname(ich, pvname, lenpv)
      print 100
 100  format (1x, 'chn#',
     &        1x, 'channel_name        ',
     &        1x, '  v_set',
     &        1x, ' mvdz',
     &        1x, ' mcdz',
     &        1x, 'ramp_up',
     &        1x, 'ramp_dn',
     &        1x, ' trip_I',
     &        1x, 'enable')
      call read_set_v(ich, v_set)
      call read_mvdz(ich, mvdz)
      call read_mcdz(ich, mcdz)
      call read_ramp_up(ich, ramp_up)
      call read_ramp_down(ich, ramp_down)
      call read_trip_current(ich, trip_current)
      call read_enable(ich, enable)
      print 1000, ich, label_hv(ich), v_set, mvdz, mcdz, ramp_up,
     &  ramp_down, trip_current, enable
 1000 format (1x, i4, 1x, a20, 1x, f7.1, 2(1x, f5.1), 3(1x, f7.1),
     &  1x, i1)
      print 1900
 1900 format (1x, ' v_meas', 1x, ' i_meas', 1x, 'status')
      call g_value(pvname(1:lenpv)//'.DVI', 'double', v_set, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from get, DVI',
     &  iret_code
      call g_value(pvname(1:lenpv)//'.MVI', 'double', v_meas, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from get, MVI',
     &  iret_code
      call g_value(pvname(1:lenpv)//'.MCI', 'double', i_meas, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from get, MCI',
     &  iret_code
      call g_value(pvname(1:lenpv)//'.STI', 'short', status, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from get, STI',
     &  iret_code
      print 2000, v_meas, i_meas, status
 2000 format (2(1x, f7.1), 1x, i1)
      return
      end
