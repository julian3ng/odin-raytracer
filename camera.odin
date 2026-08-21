package raytracer

Camera :: struct {
  origin: Vec3,
  lower_left: Vec3,
  horizontal: Vec3,
  vertical: Vec3
}

get_ray :: proc(camera: Camera, u, v: f64) -> Ray {
  return Ray {
    camera.origin,
    camera.lower_left + u*camera.horizontal + v*camera.vertical
  }
}
