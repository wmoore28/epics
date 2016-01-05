      subroutine get_pvname(ichan, pvname, length)
c numbers are mainframe, card, subcard, channel
      implicit none
      include 'hv.inc'
      character*(*) pvname
      integer*4 ichan, length, length_label
c
      length_label = index(label_hv(ichan), ' ') - 1
      write (pvname, 10) label_hv(ichan)
 10   format ('B_hv_', a20)
      length = length_label + 5
      return
c
      end
