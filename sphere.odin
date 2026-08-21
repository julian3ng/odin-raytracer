package raytracer

import "core:math"

Sphere :: struct {
  center: Vec3,
  radius: f64
}

hit_sphere :: proc(s: Sphere, r: Ray, t_min: f64, t_max: f64) -> Maybe(HitRecord) {
  center, radius := s.center, s.radius
  oc := origin(r) - center
  a := dot(direction(r), direction(r))
  b := dot(oc, direction(r))
  c := dot(oc, oc) - (radius * radius)
  discriminant := b * b - a * c
  if discriminant < 0 {
    return nil
  } else {
    soln := (-b - math.sqrt(discriminant)) / a
    if (soln < t_max && soln > t_min) {
      p := point_at_parameter(r, soln)
      return HitRecord{
        t=soln,
        p=p,
        normal=((p - center) / radius)
      }
    }
    soln = (-b + math.sqrt(discriminant)) / a
    if (soln < t_max && soln > t_min) {
      p := point_at_parameter(r, soln)
      return HitRecord{
        t=soln,
        p=p,
        normal=((p - center) / radius)
      }
    }
    return nil
  }
}
