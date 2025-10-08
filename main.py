import control as cs
import numpy as np
import matplotlib.pyplot as plt


s = cs.tf("s")
G = 1 / (s * (s + 1) * (s + 2))

# cs.rlocus(G)
cs.bode_plot(G, display_margins=True)
figure, ax = plt.subplots()
t, y = cs.step_response(cs.feedback(G, 1))
# plt.plot(t, y)
# plt.grid()
cs.sisotool(G)
plt.show()