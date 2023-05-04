import numpy as np
from matplotlib import pyplot as plt

x = []
u = []
ureal = []
with open('RESULT') as table:
	for line in table:
		x.append(float(line.split()[0]))
		u.append(float(line.split()[1]))
		ureal.append(float(line.split()[2]))

plt.figure()
plt.title('Первый шаг по времени')
plt.xlabel('x [м]')
plt.ylabel(r'T [$^\circ C$]')
plt.plot(x, ureal, 'r-', label = 'решение')
plt.plot(x, u, 'b--', label = 'численно')
plt.legend()

plt.figure()
plt.title('Невязка')
plt.xlabel('x [м]')
plt.ylabel(r'T [$^\circ C$]')
plt.plot(x, np.array(u) - np.array(ureal), 'r--', label = r'$T_{comp} - T_{real}$')
plt.legend()

plt.show()
