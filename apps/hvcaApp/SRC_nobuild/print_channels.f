      subroutine print_channels(ipage)
      implicit none
      include 'hv.inc'
      character*100 pvname
      integer*4 ipage, ich, iret_code, lenpv
      integer*2 status
      real*8 v_set, v_meas, i_meas
      print 100
 100  format (1x, 'chn#',
     &        1x, 'channel_name        ',
     &        1x, '  v_set',
     &        1x, ' v_meas',
     &        1x, ' i_meas',
     &        1x, 'status')
      do ich = 20*(ipage - 1) + 1, min(20*ipage, nchan_hv)
        call get_pvname(ich, pvname, lenpv)
        call g_value(pvname(1:lenpv)//'.DVI', 'double', v_set, 1,
     &    iret_code)
        if (iret_code .ne. 0) print *, ' return code from get, DVI',
     &    iret_code
        call g_value(pvname(1:lenpv)//'.MVI', 'double', v_meas, 1,
     &    iret_code)
        if (iret_code .ne. 0) print *, ' return code from get, MVI',
     &    iret_code
        call g_value(pvname(1:lenpv)//'.MCI', 'double', i_meas, 1,
     &    iret_code)
        if (iret_code .ne. 0) print *, ' return code from get, MCI',
     &    iret_code
        call g_value(pvname(1:lenpv)//'.STI', 'short', status, 1,
     &    iret_code)
        if (iret_code .ne. 0) print *, ' return code from get, STI',
     &    iret_code
        print 1000, ich, label_hv(ich), v_set, v_meas, i_meas, status
 1000   format (1x, i4, 1x, a20, 3(1x, f7.1), 1x, i1)
      end do
      return
      end
