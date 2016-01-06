      program mkdat
      implicit none
      character*20 label
      integer*4 mf, ich, i, card, channel, group, enable, v_set, mvdz,
     &  mcdz, ramp_up, ramp_down, trip_current, sign
c
      do i = 1, 3
        write (20, *) ' HV data file'
      end do
      mf = 1
      enable = 1
      v_set = 1000
      mvdz = 15
      mcdz = 5
      ramp_up = 300
      ramp_down = 400
      trip_current = 50
      ich = 0
      do card = 0, 15
        if (card .eq. 0) then
          sign = 1
        else
          sign = -1
        end if 
        group = card + 1
        do channel = 0, 11
          ich = ich + 1
          write (label, 100) ich
 100      format ('channel ', i3, 9x)
          write (20, 200) label, group, enable, mf, card, channel,
     &      sign*v_set, mvdz, mcdz, ramp_up, ramp_down,
     &      sign*trip_current
 200      format (' ''', a20, '''', 1x, i2, 1x, i1, 3(1x, i2), 1x, i5,
     &      1x, i3, 1x, i2, 2(1x, i3), 1x, i4)
        end do
      end do
      write (20, 300)
 300  format (' ''end''')
      stop
      end
