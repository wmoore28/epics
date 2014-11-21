      subroutine show_settings(ipage)
      implicit none
      include 'hv.inc'
      integer*4 ipage, ich
      integer*2 enable
      real*8 v_set, mvdz, mcdz, ramp_up, ramp_down, trip_current
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
      do ich = 20*(ipage - 1) + 1, min(20*ipage, nchan_hv)
        call read_set_v(ich, v_set)
        call read_mvdz(ich, mvdz)
        call read_mcdz(ich, mcdz)
        call read_ramp_up(ich, ramp_up)
        call read_ramp_down(ich, ramp_down)
        call read_trip_current(ich, trip_current)
        call read_enable(ich, enable)
        print 1000, ich, label_hv(ich), v_set, mvdz, mcdz, ramp_up,
     &    ramp_down, trip_current, enable
 1000   format (1x, i4, 1x, a20, 1x, f7.1, 2(1x, f5.1), 3(1x, f7.1),
     &    1x, i1)
      end do
      return
      end
