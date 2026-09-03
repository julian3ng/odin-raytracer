package raytracer

Lambertian :: struct {
  albedo: Vec3
}

Metal :: struct {
  albedo: Vec3
}

Material :: union {
  Lambertian,
  Metal,
}

Scattering :: struct {
  scattered: Ray,
  attenuation: Vec3,
}

lambertian_scatter :: proc(material: Lambertian, hr: HitRecord, ray: Ray) -> Maybe(Scattering) {
  target := hr.p + hr.normal + random_in_unit_sphere()
  scattered := Ray{hr.p, target - hr.p}
  attenuation := material.albedo
  return Scattering{scattered, attenuation}
}


reflect :: proc(v: Vec3, n: Vec3) -> Vec3 {
  return v - 2 * dot(v, n) * n;
}

metal_scatter :: proc(material: Metal, hr: HitRecord, ray: Ray) -> Maybe(Scattering) {
  reflected := reflect(normalized(direction(ray)), hr.normal)
  scattered := Ray{hr.p, reflected}
  attenuation := material.albedo
  if (dot(direction(scattered), hr.normal) > 0.0) {
    return Scattering{scattered, attenuation}
  }
  return nil
}

// Don't know how to do this properly... Is there a way with proc { }?
scatter :: proc(material: Material, hr: HitRecord, ray: Ray) -> Maybe(Scattering) {
  switch m in material {
  case Lambertian: return lambertian_scatter(material.(Lambertian), hr, ray)
  case Metal: return metal_scatter(material.(Metal), hr, ray)  
  }
  return nil
}
