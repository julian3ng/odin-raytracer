package raytracer

import "core:math"
import "core:math/rand"

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

random_in_unit_sphere :: proc() -> Vec3 {
  v : Vec3 = ({ rand.float64(), rand.float64(), rand.float64() } * 2.0) - { 1.0, 1.0, 1.0 }
  // rejection sampling: randomize until we hit something with a sub-1 norm.
  for (length(v) > 1.0) {
    v = ({ rand.float64(), rand.float64(), rand.float64() } * 2.0) - { 1.0, 1.0, 1.0 }
  }
  return v
}
