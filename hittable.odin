package raytracer

HitRecord :: struct {
  t: f64,
  p: Vec3,
  normal: Vec3
}

Hittable :: union {
  Sphere,
}

hit_list :: proc(hl: []Hittable, r: Ray, t_min: f64, t_max: f64) -> Maybe(HitRecord) {
  for obj in hl {
    hr, hr_ok := hit(obj.(Sphere), r, t_min, t_max).?
    if hr_ok {
      return hr
    }
  }
  return nil
}

hit :: proc {
  hit_sphere
}
