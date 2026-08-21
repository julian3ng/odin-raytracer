package raytracer

import "core:fmt"
import "core:os"

W := 200
H := 100

color :: proc(r: Ray, world: []Hittable) -> [3]f64 {
  if hr, hr_ok := hit_list(world, r, 0.0, 3).?; hr_ok {
    normal := hr.normal
    return 0.5 * Vec3{normal.x + 1, normal.y + 1, normal.z + 1}
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

  lower_left := Vec3 { -1.0 * f64(W) / 100.0, -1.0 * f64(H) / 100.0, -1.0 }
  horizontal := Vec3 { 2.0 * f64(W) / 100.0 , 0.0, 0.0 }
  vertical := Vec3 { 0.0, 2.0 * f64(H) / 100.0, 0.0 }
  origin := Vec3 { 0.0, 0.0, 0.0 }

  world := []Hittable{
    Sphere{
      center=[3]f64{0.0, 0.0, -1.0},
      radius=0.5
    },
    Sphere{
      center=[3]f64{0.0, -100.5, -1.0},
      radius=100.0
    },
  }

  for i:=H-1; i>=0; i-=1 {
    for j:=0; j<W; j+=1 {
      u := f64(j) / f64(W)
      v := f64(i) / f64(H)

      r := Ray {
        origin,
        lower_left + u*horizontal + v*vertical
      }

      c := color(r, world) * 255.99
      fmt.fprintfln(img, "%d %d %d", u8(c.r), u8(c.g), u8(c.b))
    }
  }

  os.close(img)
}
