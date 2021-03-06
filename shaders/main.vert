#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 tangent;
layout (location = 3) in vec2 uv;

uniform mat4 model_transform;
uniform mat4 normal_transform;
uniform mat4 view_transform;
uniform mat4 projection_transform;

out vec3 Normal;
out vec2 UV;
out vec3 WorldPosition;
out mat3 TBN;

void main() {
  gl_Position = projection_transform * view_transform * model_transform * vec4(position, 1.0);
  WorldPosition = vec3(model_transform * vec4(position, 1.0));
  Normal = normalize(mat3(normal_transform) * normal);
  UV = uv;

  vec3 normalized_tangent = normalize(mat3(normal_transform) * tangent);
  vec3 normalized_normal = normalize(mat3(normal_transform) * normal);
  vec3 normalized_bitangent = normalize(cross(normalized_tangent, normalized_normal));
  TBN = mat3(normalized_tangent, normalized_bitangent, normalized_normal);
}
