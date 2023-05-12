module modd
use matrix_solver
implicit none
real(8) :: pi = 4 * atan(1.d0)

contains

subroutine InitializeParameters(D, a, b, u_left, u_right, N, C, t_stop, upper_n)
! Subroutine for setting model parameters
integer :: N, upper_n
real(8) :: C, D, a, b, u_left, u_right, t_stop
open(unit = 1, file = 'INPUT')
read(1, *) D
read(1, *) a
read(1, *) b
read(1, *) u_left
read(1, *) u_right
read(1, *) N
read(1, *) C
read(1, *) t_stop
read(1, *) upper_n
end subroutine InitializeParameters


subroutine Allocation(N, u_old2, u_old1, u_new, x, res)
! Subroutine for allocating memory to dynamic arrays
integer :: N
real(8), allocatable :: u_old2(:), u_old1(:), u_new(:), x(:), res(:)
allocate(u_old2(0:N-1))
allocate(u_old1(0:N-1))
allocate(u_new(0:N-1))
allocate(x(0:N-1))
allocate(res(0:N-1))
end subroutine Allocation


subroutine InitializeGrid(N, C, D, a, b, x, dx, dt)
! Subroutine for initialising the grid
real(8) :: a, b, C, D
integer :: N, i
real(8) :: dx, dt, x(0:N-1)
dx = (b - a) / (N - 1)
dt = C * dx**2 / D
! dt = dx**2 corresponds to C = D
x(0) = a; x(N-1) = b
do i = 1, N-2
	x(i) = x(i-1) + dx
enddo
end subroutine InitializeGrid


subroutine SetIC(N, x, u_old)
! Subroutine for setting the initial condition
integer :: N, i
real(8) :: u_old(0:N-1), x(0:N-1)
do i = 0, N-1
	if (x(i) <= 0.5) then
		u_old(i) = 100.d0
	else
		u_old(i) = 20.d0
	endif
enddo
end subroutine SetIC


subroutine FirstStep(N, D, dx, dt, u_old, u_new)
! Subroutine for the first time step with implicit Crank–Nicolson method
integer :: N, i, j
real(8) :: D, dx, dt
real(8) :: x(0:N-1), u_old(0:N-1), u_new(0:N-1)
real(8) :: b_vector(0:N-1)
real(8) :: alpha_vector(0:N-2), beta_vector(0:N-1), gamma_vector(1:N-1)
! We use Thomas algorithm to solve a specific tridiagonal matrix from
! Crank–Nicolson method.
beta_vector(0) = 1.d0
alpha_vector(0) = 0.d0
b_vector(0) = 100.d0
do i = 1, N-2
	beta_vector(i) = - D / (dx**2) - 1 / dt ! the main diagonal
	alpha_vector(i) = D / (2 * dx**2) ! the upper subdiagonal
	gamma_vector(i) = D / (2 * dx**2) ! the lower subdiagonal
	b_vector(i) = - u_old(i) / dt + (D / (2 * dx**2)) * (2 * u_old(i) - u_old(i+1) - u_old(i-1)) ! right parts
enddo
gamma_vector(N-1) = 0.d0
beta_vector(N-1) = 1.d0
b_vector(N-1) = 20.d0
call tridiagonal(N, alpha_vector, beta_vector, gamma_vector, b_vector, u_new)
end subroutine FirstStep


subroutine UpdateIC(N, u_old2, u_old1, u_new)
!Subroutine for updating the initial condition
integer :: N
real(8) :: u_new(0:N-1), u_old1(0:N-1), u_old2(0:N-1)
u_old2 = u_old1
u_old1 = u_new
end subroutine UpdateIC


subroutine SetBC(N, u_left, u_right, u)
!Subroutine for setting the boundary condition
integer :: N
real(8) :: u_left, u_right
real(8) :: u(0:N-1)
u(0) = u_left
u(N-1) = u_right
end subroutine SetBC


subroutine Step(N, C, u_old2, u_old1, u_new)
!Time step according to the DuFort-Frankel scheme
real(8) :: C, c2
integer :: N, i
real(8) :: u_new(0:N-1), u_old1(0:N-1), u_old2(0:N-1)
c2 = 2 * C
do i = 1, N-2
	u_new(i) = ((1 - c2) * u_old2(i) + c2 * (u_old1(i+1) + u_old1(i-1))) / (1 + c2)
enddo
end subroutine Step


subroutine SaveData(N, u_new, x, res, t_stop, C)
real(8) :: x(0:N-1), u_new(0:N-1), res(0:N-1), C, t_stop
integer :: N, i
open(unit = 2, file = 'RESULT')
write(2,*) N, C, t_stop
do i = 0, N-1
	write(2,*) x(i), u_new(i), res(i)
enddo
end subroutine SaveData


subroutine Solution(N, x, t, D, upper_n, res)
integer :: upper_n, m, N, i
real(8) :: D
real(8) :: x(0:N-1), t, res(0:N-1)
res = 0.d0
do m = 1, upper_n
	do i = 0, N-1
		res(i) = res(i) + (-1)**(m+1) * exp(-4 * D * pi**2 * m**2 * t) * sin(2 * pi * m * x(i)) / m
	enddo
enddo
res = 80.d0 * res / pi + 100.d0 - 80.d0 * x	
end subroutine


end module
