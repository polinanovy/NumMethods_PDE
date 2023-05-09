program main
use modd

implicit none

integer :: N
integer :: upper_n
real(8) :: C
real(8) :: D
real(8) :: a, b
real(8) :: u_left, u_right
real(8) :: dx, dt, t, t_stop
real(8), allocatable :: u_old2(:), u_old1(:), u_new(:), x(:), res(:), u(:)

! Read the following parameters from file 'INPUT':
call InitializeParameters(D, a, b, u_left, u_right, N, C, t_stop, upper_n)
! Allocate the following arrays using N:
call Allocation(N, u_old2, u_old1, u_new, x, res)
! Get grid step sizes dx and dt, as well as the array of coordinates "x":
call InitializeGrid(N, C, D, a, b, x, dx, dt)
! Set initial condition (t = 0):
call SetIC(N, x, u_old2)
! Start timer (t = 0 omitted due to performing first step separately):
t = dt
! Perform the first step with implicit Crank–Nicolson method (t = dt):
call FirstStep(N, D, dx, t, u_old2, u_old1)
! Main loop: realisation of the DuFort-Frankel method:
do while (t <= t_stop)
	! Set boundary condition:
	call SetBC(N, u_left, u_right, u_new)
	! Perform one time step:
    call Step(N, D, dt, dx, u_old2, u_old1, u_new)
    ! Update initial conditions:
    call UpdateIC(N, u_old2, u_old1, u_new)
    ! Update timer:
	t = t + dt
end do
! Compute the solution with a given formula (see the report)
! using truncated Fourier series with upper limit "upper_n":
call Solution(N, x, t, D, upper_n, res)
! Save data to file 'RESULT':
call SaveData(N, u_new, x, res, t_stop, C)

end
