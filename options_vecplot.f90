!-------------------------------------------------------------------------
! Module containing settings and options relating to vector plots
! includes default values of these options and submenu for changing them
!-------------------------------------------------------------------------
module settings_vecplot
 implicit none
 integer :: npixvec
 logical :: UseBackgndColorVecplot, iplotpartvec
 logical :: iVecplotLegend,iplotstreamlines,iplotarrowheads
 real :: hposlegendvec,vposlegendvec

 namelist /vectoropts/ npixvec, UseBackgndColorVecplot,iplotpartvec,&
          iVecplotLegend,hposlegendvec,vposlegendvec,iplotstreamlines, &
          iplotarrowheads

contains

!---------------------------------------------
! set default values for these options
!---------------------------------------------
subroutine defaults_set_vecplot
  implicit none

  npixvec = 40        ! pixels in x direction on vector plots
  UseBackgndColorVecplot = .false. ! plot vector plot using black/white
  iplotpartvec = .true.   ! whether to plot particles on vector plot
  iVecplotLegend = .true.
  hposlegendvec = 0.02
  vposlegendvec = -1.5
  iplotstreamlines = .false. ! plot stream lines instead of arrows
  iplotarrowheads = .true.

  return
end subroutine defaults_set_vecplot

!----------------------------------------------------------------------
! sets options relating to vector plots
!----------------------------------------------------------------------
subroutine submenu_vecplot(ichoose)
 use prompting
 implicit none
 integer, intent(in) :: ichoose
 integer :: ians
  
 ians = ichoose
 print "(a)",'--------------- vector plot options -------------------'

 if (ians.le.0 .or. ians.gt.5) then
    print 10,npixvec,print_logical(UseBackgndColorVecplot), &
             print_logical(iVecplotLegend),print_logical(iplotstreamlines), &
             print_logical(iplotarrowheads)
10  format( &
             ' 0) exit ',/, &
             ' 1) change number of pixels                   (',i4,' )',/, &
             ' 2) use background colour for arrows          ( ',a,' )',/, &
             ' 3) vector plot legend settings               ( ',a,' )',/, &
             ' 4) plot stream/field lines instead of arrows ( ',a,' )',/, &
             ' 5) turn arrow heads on/off                   ( ',a,' )')
    call prompt('enter option',ians,0,5)
 endif
!
!--options
!
 select case(ians)
!------------------------------------------------------------------------
 case(1)
    call prompt('enter number of pixels',npixvec,1,1000) 
!------------------------------------------------------------------------
 case(2)
    UseBackgndColorVecplot = .not.UseBackgndColorVecplot
    print*,'use background colour on vector plots = ', &
           print_logical(UseBackgndColorVecplot)
!------------------------------------------------------------------------
 case(3)
    call prompt('plot vector legend?',iVecplotLegend)
    if (iVecplotLegend) then
       print*,'note that the following settings can also be changed interactively'
       call prompt('Enter horizontal position as fraction of viewport', &
                   hposlegendvec,0.0,1.0)
       call prompt('Enter vertical position in character heights from top', &
                    vposlegendvec)
    endif
!------------------------------------------------------------------------
 case(4)
    iplotstreamlines = .not.iplotstreamlines
    print "(2(a,/))",' Note: the number of stream lines plotted is determined by', &
                     ' the "change number of contours" option in the r)ender menu'
    call prompt('use stream lines instead of arrows? ',iplotstreamlines)
!------------------------------------------------------------------------
 case(5)
    iplotarrowheads = .not.iplotarrowheads
    call prompt('plot arrow heads? ',iplotarrowheads)
 end select

 return
end subroutine submenu_vecplot

end module settings_vecplot
