      subroutine parse (line, label_hv, group_hv,
     &      enable_hv,
     &      ioc_hv,
     &      mf_hv,
     &      card_hv, submod_hv, chan_hv, set_v, mvdz, mcdz,
     &      ramp_up, ramp_down, trip_current, v_limit)
      implicit none
      character*100 line
      character*20 label_hv
      integer*4 group_hv, enable_hv, ioc_hv,
     &  mf_hv, card_hv, submod_hv, chan_hv,
     &  iblank
      real*8 set_v, mvdz, mcdz,
     &      ramp_up, ramp_down, trip_current, v_limit
      iblank = index(line, ' ')
      label_hv = line(1:iblank - 1)
      line = line(iblank + 1:100)
      read (line, *) group_hv,
     &      enable_hv,
     &      ioc_hv,
     &      mf_hv,
     &      card_hv, submod_hv, chan_hv, set_v, mvdz, mcdz,
     &      ramp_up, ramp_down, trip_current, v_limit
      return
      end
