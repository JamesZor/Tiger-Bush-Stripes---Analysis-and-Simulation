
# Tiger Bush Stripes (Pattern-Forming Instabillity - Turing Pattens) Analysis and Simulation

## Description
This assignment provides an overview of Tiger Bush, a fascinating natural phenomenon characterized by pattern-forming instability known as Turing patterns. We explore the concept of Tiger Bush, its formation, and the underlying mechanism of pattern generation through Turing patterns.

![Alt text](figures/tigerbush.jpg?raw=true "TigerBush")
![Alt text](figures/Q6_fig1.jpg?raw=true "SimTigerBush")

## Tiger Bush
Tiger bushes are distinct vegetation patterns that resemble the stripes on a tiger's fur. They can be observed in various types of vegetation and soil, particularly in semiarid regions on hillsides with gradual slopes. These patterns arise from the interplay between vegetation growth, water dynamics, and terrain characteristics.

## Pattern-Forming Instability
Pattern-forming instability, specifically Turing patterns, is a mathematical concept that explains the spontaneous formation of patterns in reaction-diffusion systems. In the context of Tiger Bush, Turing patterns elucidate the emergence of distinctive stripe-like vegetation patterns.

## Theoretical Model
A minimal model for Tiger Bush formation involves a set of partial differential equations (PDEs) that describe the dynamics of vegetation and water. These equations capture the diffusion of vegetation, plant death, water uptake by plants, water advection, rainfall, evaporation, and water uptake by plants affecting the water concentration.

Tiger bushes are patterns of vegetation that resemble the stripes on the fur of a tiger. They can occur for many vegetation types and in many soil types. In semiarid regions, these patterns are seen on hillsides with a very gradual slope. 

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

