program main
use modd

implicit none

real(8) :: D
real(8) :: a, b
real(8) :: u_left, u_right, c2
integer :: N, i

real(8), allocatable :: u_old(:), u_new(:), x(:), res(:), u(:)

real(8) :: dx, dt, t, t_stop

call InitializeParameters(D, a, b, u_left, u_right, N, t_stop)

call Allocation(N, u_old, u_new, x)

call InitializeGrid(N, a, b, x, dx, dt)

call SetIC(N, x, u_old)

t = 0.d0

! Performing first step with implicit Crank–Nicolson method:
call FirstStep(N, D, dx, dt, u_old, u_new)
allocate(res(0:N-1))
!call Solution(N, x, dt, D, 10000, res)

!t = t + dt
!open(unit = 1, file = 'RESULT')
!do i = 0, N-1
!	write(1, *) x(i), u_new(i), res(i) 
!enddo	
	
call UpdateIC(x(2), u_new(2))

u_old = u_new
t = t + dt
c2 = (2*D*dt)/dx**2
allocate(u(0:N-1))
do while (t <= t_stop)
	call SetBC(N, u_left, u_right, u_new)
    u = u_new
    do i = 1, N-2
        u_new(i) = ((1-c2)*u_old(i)+c2*(u_new(i+1)+u_new(i-1)))/(1+c2)
        call UpdateIC(x(i+1), u_new(i+1))
    enddo
    u_old = u
	t = t + dt
end do

call Solution(N, x, t, D, 10000, res)

call SaveData(N, u_new, x, res)

end
