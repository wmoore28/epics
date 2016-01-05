      subroutine write_ramp_up(ich, ramp_up)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv
      real*8 ramp_up
      call get_pvname(ich, pvname, lenpv)
      call p_value(pvname(1:lenpv)//'.RUO', 'double', ramp_up, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      return
      end
