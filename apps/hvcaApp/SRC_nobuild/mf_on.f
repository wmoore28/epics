      subroutine mf_on(mfno)
      implicit none
      integer*4 one
      parameter (one = 1)
      character*1 cno
      integer*4 mfno, iret_code
      write (cno, 100) mfno
 100  format (i1)
      call p_value('B/real_HVON_set'//cno//'.PROC', 'long', one, 1,
     &  iret_code)
      if (iret_code .ne. 0) print *, 'mf_on: iret_code = ', iret_code
      return
      end
