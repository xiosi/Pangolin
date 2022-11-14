@start vertex
#version 150 core

uniform mat4 proj;
uniform mat4 cam_from_world;
uniform vec2 image_size;
out vec2 v_tex;

const vec2 pos[4] = vec2[4](
  vec2( 0.0, 1.0), vec2( 0.0, 0.0),
  vec2( 1.0, 1.0), vec2( 1.0, 0.0)
);

void main()
{
  // v_tex is continous coordinate system
  v_tex = pos[gl_VertexID];
  // v_img is vision style coordinate system with discrete pixel
  // indexing
  vec2 v_img = v_tex * image_size - vec2(0.5);

  // The canonical texture coordinates are mapped to the z=0 plane
  // with pixel units. They will span (-0.5,0.5) - (w-0.5, h-0.5)
  // such that integral pixel lookups will fall on the center of pixel
  // samples in the texture
  gl_Position = proj * cam_from_world * vec4(v_img, 0.0, 1.0);
}

@start fragment
#version 150 core

in vec2 v_tex;

uniform sampler2D image;
uniform mat4 color_transform;

out vec4 color;
void main()
{
  // lookup linearly interpolated
  color = color_transform * texture(image, v_tex);
}