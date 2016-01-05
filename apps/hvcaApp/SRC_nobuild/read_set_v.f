      subroutine read_set_v(ich, set_v)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv
      real*8 set_v
      call get_pvname(ich, pvname, lenpv)
      call g_value(pvname(1:lenpv)//'.DVI', 'double', set_v, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from get', iret_code
      return
      end
