      subroutine write_ramp_down(ich, ramp_down)
      implicit none
      character*100 pvname
      integer*4 ich, iret_code, lenpv
      real*8 ramp_down
      call get_pvname(ich, pvname, lenpv)
      call p_value(pvname(1:lenpv)//'.RDO', 'double', ramp_down, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, ' return code from put', iret_code
      return
      end
