library(tidyverse)
library(magick)
library(cowplot)

a <- ggdraw() + draw_image("results/figures/PPI_Exp_Scheme.png")
b <- ggdraw() + draw_image("results/figures/before_abx.png")
c <- ggdraw() + draw_image("results/figures/families_prev_assoc_w_PPIs.png")
d <- ggdraw() + draw_image("results/figures/before_plus_day_after_abx.png")

plot_grid(a, b, c, d, labels = "AUTO")+
  ggsave("results/figures/figure_1.pdf", width=6.5, height=6)+
  ggsave("submission/figure_1.pdf", width=6.5, height=6)

