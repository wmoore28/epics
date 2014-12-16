      subroutine read_mcdz(ich, mcdz)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv
      real*8 mcdz
      call get_pvname(ich, pvname, lenpv)
      call g_value(pvname(1:lenpv)//'.CZI', 'double', mcdz, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from get', iret_code
      return
      end
