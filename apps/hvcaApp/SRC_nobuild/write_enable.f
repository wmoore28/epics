      subroutine write_enable(ich, ienable)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv
      integer*2 ienable
      call get_pvname(ich, pvname, lenpv)
      call p_value(pvname(1:lenpv)//'.CEO', 'short', ienable, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      return
      end
