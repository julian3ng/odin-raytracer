package raytracer

hit_sphere :: proc(center: Vec3, radius: f64, ray: Ray) -> bool {
  oc := origin(ray) - center
  a := dot(direction(ray), direction(ray))
  b := 2.0 * dot(oc, direction(ray))
  c := dot(oc, oc) - (radius * radius)
  return b * b - 4 * a * c > 0
}
