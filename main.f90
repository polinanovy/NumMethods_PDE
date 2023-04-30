program main
use modd

implicit none

real(8) :: D
real(8) :: a, b
real(8) :: u_left, u_right
real(8) :: N

real(8), allocatable :: u_old(:), u_new(:)

real(8) :: dx, dt

real(8) :: t, t_stop

call InitializeParameters(D, a, b, u_left, u_right, N, t_stop)

call Allocation(N, u_old)

call InitializeGrid(N, a, b, dx, dt)

call SetIC(N, u_old)

t = 0.d0

! Performing first step with implicit Crank–Nicolson method:
call FirstStep(N, u_old, u_new)

call UpdateIC(N, u_old, u_new)

do while (t <= t_stop)
	call SetBC(N, a, b, u_old)
	call Step(N, u_old, u_new)
	call UpdateIC(N, u_old, u_new)
	t = t + dt
end do

call SaveData(N, u_new)

end
