program main
use modd

implicit none

real(8) :: D
real(8) :: a, b
real(8) :: u_left, u_right
integer :: N, i

real(8), allocatable :: u_old(:), u_new(:), x(:), res(:)

real(8) :: dx, dt, t, t_stop

call InitializeParameters(D, a, b, u_left, u_right, N, t_stop)

call Allocation(N, u_old, u_new, x)

call InitializeGrid(N, a, b, x, dx, dt)

call SetIC(N, x, u_old)

t = 0.d0

! Performing first step with implicit Crank–Nicolson method:
call FirstStep(N, D, dx, dt, u_old, u_new)
allocate(res(0:N-1))
call Solution(N, x, dt, D, 10000, res)

t = t + dt
open(unit = 1, file = 'RESULT')
do i = 0, N-1
	write(1, *) x(i), u_new(i), res(i) 
enddo	
	
!call UpdateIC(N, u_old, u_new)

!do while (t <= t_stop)
	!call SetBC(N, a, b, u_old)
	!call Step(N, u_old, u_new)
	!call UpdateIC(N, u_old, u_new)
	!t = t + dt
!end do

!call SaveData(N, u_new)

end
