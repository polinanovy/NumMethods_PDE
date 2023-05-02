module modd
use matrix_solver
implicit none
contains

subroutine InitializeParameters(D, a, b, u_left, u_right, N, t_stop)
! Subroutine for setting model parameters
integer :: N
real(8) :: D, a, b, u_left, u_right, t_stop
open(unit = 1, file = 'INPUT')
read(1, *) D
read(1, *) a
read(1, *) b
read(1, *) u_left
read(1, *) u_right
read(1, *) N
read(1, *) t_stop
end subroutine InitializeParameters


subroutine Allocation(N, u_old, u_new, x)
! Subroutine for allocating memory to dynamic arrays
integer :: N
real(8), allocatable :: u_old(:), u_new(:), x(:)
allocate(u_old(0:N-1))
allocate(u_new(0:N-1))
allocate(x(0:N-1))
end subroutine Allocation


subroutine InitializeGrid(N, a, b, x, dx, dt)
! Subroutine for initialising the grid
real(8) :: a, b 
integer :: N, i
real(8) :: x(0:N-1)
real(8) :: dx, dt
dx = (b - a) / (N - 1)
dt = dx**2
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
	beta_vector(i) = - D / (2 * dx**2) - 1 / dt ! the main diagonal
	alpha_vector(i) = D / (2 * dx**2) ! the upper subdiagonal
	gamma_vector(i) = D / (2 * dx**2) ! the lower subdiagonal
	b_vector(i) = - u_old(i) / dt + (D / (2 * dx**2)) * (2 * u_old(i) - u_old(i+1) - u_old(i-1)) ! right parts
enddo
gamma_vector(N-1) = 0.d0
beta_vector(N-1) = 1.d0
b_vector(N-1) = 20.d0
call tridiagonal(N, alpha_vector, beta_vector, gamma_vector, b_vector, u_new)
end subroutine FirstStep


subroutine UpdateIC()
!Subroutine for updating the initial condition

end subroutine UpdateIC


subroutine SetBC()
!Subroutine for setting the boundary condition

end subroutine SetBC


subroutine Step()
!Time step according to the DuFort-Frankel scheme
real(8) :: D, dt, dx!, 2c
integer :: N
!real(8) :: u(
!2c = (2*D*dt)/dx**2
!u(1:N−2) = ((1−2c)*u_old(1:N−2) + 2c*(u(2:N-1) + u(0:N−3))) / (1+2c)
end subroutine Step


subroutine SaveData()

end subroutine SaveData


end module
