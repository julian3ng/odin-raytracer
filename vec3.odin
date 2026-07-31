package raytracer

import "core:math"

Vec3 :: [3]f64

dot :: proc(v : Vec3, w : Vec3) -> f64 {
  return v.x * w.x + v.y * w.y + v.z * w.z
}

length :: proc(v: Vec3) -> f64 {
  return math.sqrt_f64(v.x * v.x + v.y * v.y + v.z * v.z)
}

length_squared :: proc(v: Vec3) -> f64 {
  return v.x * v.x + v.y * v.y + v.z * v.z
}

normalized :: proc(v: Vec3) -> Vec3 {
  return v / length(v)
}
