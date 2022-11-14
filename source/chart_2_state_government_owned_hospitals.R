library(ggplot2)
world_shape <- map_data("world")
view(world_shape)
ggplot(world_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group),
    color = "white",
    size = .1
  ) +
  coord_map()