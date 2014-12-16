      subroutine make_dat
      implicit none
      integer*4 lunout
      parameter (lunout = 40)
      include 'hv.inc'
      character*100 filename
      integer*4 ich, ienable_soft
c      integer*2 enable
      real*8 v_set, mvdz, mcdz, ramp_up, ramp_down, trip_current,
     &  vmax_soft
      data ienable_soft/1/, vmax_soft/-2500./
c
      print *, ' output file name:'
      read 5, filename
 5    format (a100)
      open (unit = lunout, file = filename, status = 'new')
      do ich = 1, nchan_hv
        call read_set_v(ich, v_set)
        call read_mvdz(ich, mvdz)
        call read_mcdz(ich, mcdz)
        call read_ramp_up(ich, ramp_up)
        call read_ramp_down(ich, ramp_down)
        call read_trip_current(ich, trip_current)
c        call read_enable(ich, enable)
        print *, ' make_dat: ', label_hv(ich)
        write (lunout, 1000) label_hv(ich), group_hv(ich),
     &    ienable_soft, ioc_hv(ich), mf_hv(ich), card_hv(ich),
     &    submod_hv(ich), chan_hv(ich), v_set,
     &    mvdz, mcdz, ramp_up,
     &    ramp_down, trip_current, vmax_soft
 1000   format (a20, 1x, i2.2, 1x, i1, 5(1x, i2.2), 1x, f7.1,
     &    2(1x, f5.1), 4(1x, f7.1))
      end do
      close (unit=lunout)
      return
      end
