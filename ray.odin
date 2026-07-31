package raytracer

import "core:math"

Ray :: struct {
  a: Vec3,
  b: Vec3,
}

origin :: proc(r: Ray) -> Vec3 {
  return r.a
}

direction :: proc(r: Ray) -> Vec3 {
  return r.b
}

point_at_parameter :: proc(r: Ray, t: f64) -> Vec3 {
  return r.a + t * r.b
}
