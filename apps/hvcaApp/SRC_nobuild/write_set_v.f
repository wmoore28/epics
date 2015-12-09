      subroutine write_set_v(ich, set_v)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv, minor/1/, major/2/
      real*8 set_v
      real*4 vhh, vh, vl, vll
      vhh = set_v + 100.0
      vh = set_v + 50.0
      vl = set_v - 50.0
      vll = set_v - 100.0
      call get_pvname(ich, pvname, lenpv)
      call p_value(pvname(1:lenpv)//'.DVO', 'double', set_v, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HHMV', 'float', vhh, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HIMV', 'float', vh, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LOMV', 'float', vl, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LLMV', 'float', vll, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HHSV', 'long', major, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.HSMV', 'long', minor, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LSMV', 'long', minor, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      call p_value(pvname(1:lenpv)//'.LLSV', 'long', major, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      return
      end
