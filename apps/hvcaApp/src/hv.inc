      integer*4 mchan_hv
      parameter (mchan_hv = 2000)
      character*20 label_hv
      integer*4 nchan_hv, ioc_hv, mf_hv, card_hv, submod_hv,
     &  chan_hv,
     &  group_hv, enable_hv
      common /hvcm/ nchan_hv, label_hv(mchan_hv), ioc_hv(mchan_hv),
     &  mf_hv(mchan_hv),
     &  card_hv(mchan_hv), submod_hv(mchan_hv), chan_hv(mchan_hv),
     &  group_hv(mchan_hv),
     &  enable_hv(mchan_hv)
