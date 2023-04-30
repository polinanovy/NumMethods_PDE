module modd
implicit none
contains

subroutine InitializeParameters(D, a, b, u_left, u_right, N, t_stop)
!Subroutine for setting model parameters

end subroutine InitializeParameters


subroutine Allocation(N,u)
!Subroutine for allocating memory to dynamic arrays
integer :: N
real(8) :: u(0:N-1)
allocate (u(0:N-1))
end subroutine Allocation


subroutine InitializeGrid(N, a, b, dx, x)
!Subroutine for initialising a grid
integer :: a, b, N, i
real(8) :: x(0:N-1)
real(8) :: dx
dx = (b - a) / (N - 1)
x(0) = a; x(N-1) = b
do i = 1, N-2
 x(i) = x(i-1) + dx
enddo
end subroutine InitializeGrid


subroutine SetIC(x, u_0)
!Subroutine for setting the initial condition

end subroutine SetIC


subroutine FirstStep(N, u_old, u_new)

end subroutine FirstStep


subroutine UpdateIC(N, u_old, u_new)
!Subroutine for updating the initial condition

end subroutine UpdateIC


subroutine SetBC(N, a, b, u_old)
!Subroutine for setting the boundary condition

end subroutine SetBC


subroutine Step(u,dt,D,dx,N,u_old)
!Time step according to the DuFort-Frankel scheme
real(8) :: D, dt, dx, 2c
integer :: N
real(8) :: u(
2c = (2*D*dt)/dx**2
u(1:N−2) = ((1−2c)*u_old(1:N−2) + 2c*(u(2:N-1) + u(0:N−3))) / (1+2c)
end subroutine Step


subroutine SaveData(N, u_new)

end subroutine SaveData


end module
