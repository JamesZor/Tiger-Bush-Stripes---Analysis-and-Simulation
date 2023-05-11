
# Tiger Bush Stripes Analysis and Simulation

In this assignment, we will analyze and simulate the formation of so-called Tiger bush Stripes.

Tiger bushes are patterns of vegetation that resemble the stripes on the fur of a tiger. They can occur for many vegetation types and in many soil types. In semiarid regions, these patterns are seen on hillsides with a very gradual slope. 


![Alt text](figures/Q6_fig1.jpg?raw=true "Title")



A minimal model for tiger bush formation is described by the following set of partial differential equations (PDEs):

```math
\begin{align*}
\frac{{\partial v}}{{\partial t}} &= \frac{{\partial^2 v}}{{\partial x^2}} - \gamma v + wv^2 \\
\frac{{\partial w}}{{\partial t}} &= \beta\frac{{\partial w}}{{\partial x}} + \alpha - w - wv^2 \\
\end{align*}
```

where $\alpha$, $\beta$, and $\gamma$ are positive real numbers.

Let's dissect the model term by term. The model has two state variables, $v(x, t)$ and $w(x, t)$, which represent the concentration of vegetation (v) and water (w) at a point $x \in [-L, L)$ and time $t \in \mathbb{R}_{\geq 0}$. We are assuming periodic boundary conditions, which is why we write compactly $x \in \mathbb{R}/2L\mathbb{Z}$. The initial conditions are omitted for the sake of brevity.

The dynamics of the vegetation is defined by the following terms:

- Plant diffusion term $\frac{\partial^2 v}{\partial x^2}$: vegetation diffuses with a diffusivity coefficient of 1.
- Plant death term $-\gamma v$: the vegetation dies at a rate $\gamma$.
- Water uptake term $wv^2$: water is taken up by plants, which proliferate proportionally to the density of water. The more water there is, the higher the proliferation rate. Without water, there is no proliferation.

The dynamics of water is defined by the following terms:

- Advection term $\beta\frac{\partial w}{\partial x}$: water is advected with a positive speed $\beta$, hence from left to right. This term models a sloped hillside with the highest point at $x = -L$ and the lowest point at $x = L$, so water flows downhill from left to right.
- Rainfall term $\alpha$: the concentration of water increases at a rate $\alpha$, which models rainfall. Rainfall is independent of $w$ and $v$.
- Evaporation term $-w$: the concentration of water decreases by evaporation, proportionally to the water density $w$.
- Water uptake term $-wv^2$: the water uptake term that appears with a positive sign in the evolution equation for $v$ must appear with a negative sign in the evolution equation for $w$. Water used by plants causes a decrease in water concentration.

