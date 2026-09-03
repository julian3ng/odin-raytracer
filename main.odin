package raytracer

import "core:math"
import "core:fmt"
import "core:os"

W := 600
H := 400

/*
* Given a ray and the world, collide the ray against all the world objects.
*/

color :: proc(r: Ray, world: []Hittable, depth: int) -> [3]f64 {
  if hr, hr_ok := hit_list(world, r, 0.000001, 10000).?; hr_ok {
    if (depth < 50) {
      if scattering, scattered_ok := scatter(hr.material, hr, r).?; scattered_ok {
        return scattering.attenuation * color(scattering.scattered, world, depth + 1);
      }
    }
    return Vec3{0.0,0.0,0.0}
  } else {
    unit_direction := normalized(direction(r))
    t := 0.5 * (unit_direction.y + 1.0)
    return (1.0 - t) * [3]f64{1.0, 1.0, 1.0} + t * [3]f64{0.3, 0.3, 0.7}
  }
}

main :: proc() {
  img, ok := os.open("./img.ppm", os.File_Flags{.Write, .Create})

  fmt.fprintln(img, "P3")
  fmt.fprintfln(img, "%d %d", W, H)
  fmt.fprintln(img, "255")


  camera := Camera {
    lower_left = Vec3 { -1.0 * f64(W) / 100.0, -1.0 * f64(H) / 100.0, -3.0 },
    horizontal = Vec3 { 2.0 * f64(W) / 100.0 , 0.0, 0.0 },
    vertical = Vec3 { 0.0, 2.0 * f64(H) / 100.0, 0.0 },
    origin = Vec3 { 0.0, 0.0, 0.0 },
  }

  world := []Hittable{
    Sphere{
      center=[3]f64{0.0, 0.0, -1.0},
      radius=0.5,
      material=Metal{Vec3{0.8,0.3,0.3}}
    },
    Sphere{
      center=[3]f64{0.0, -100.5, -1.0},
      radius=100.0,
      material=Metal{Vec3{0.2,0.2,0.2}}
    },
  }

  for i:=H-1; i>=0; i-=1 {
    for j:=0; j<W; j+=1 {
      final_color := [3]f64{ 0.0, 0.0, 0.0}
      for s:=0;s<4; s+= 1 {
        u := f64(j) / f64(W)
        v := f64(i) / f64(H)
        r := get_ray(camera, u, v)
        final_color += color(r, world, 0)
      }
      final_color /= 4.0
      final_color.r = math.sqrt_f64(final_color.r)
      final_color.g = math.sqrt_f64(final_color.g)
      final_color.b = math.sqrt_f64(final_color.b)
      final_color *= 255.59

      fmt.fprintfln(img, "%d %d %d", u8(final_color.r), u8(final_color.g), u8(final_color.b))
    }
  }

  os.close(img)
}
