      subroutine read_trip_current(ich, trip_current)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv
      real*8 trip_current
      call get_pvname(ich, pvname, lenpv)
      call g_value(pvname(1:lenpv)//'.TCI', 'double', trip_current, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from get', iret_code
      return
      end
