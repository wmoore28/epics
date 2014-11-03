      subroutine write_alarms(ich)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv, no_alarm/0/, minor/1/, major/2/
      integer*2 shh, sh, sl, sll
      real*4 ihh, ih, il, ill
c
      call get_pvname(ich, pvname, lenpv)
      ihh = 10.0
      ih = 5.0
      il = -5.0
      ill = -10.0
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HHMC', 'float', ihh, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HIMC', 'float', ih, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LOMC', 'float', il, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LLMC', 'float', ill, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HHSC', 'long', major, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HSMC', 'long', minor, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LSMC', 'long', minor, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LLSC', 'long', major, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      shh = 3
      sh = 1
      sl = 0
      sll = 0
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HHST', 'float', shh, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HIST', 'float', sh, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LOST', 'float', sl, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LLST', 'float', sll, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HHSS', 'long', major, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HSST', 'long', minor, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LSST', 'long', no_alarm, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LLSS', 'long', no_alarm, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      return
      end
