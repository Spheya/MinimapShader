#version 120
#include "lib/settings.glsl"

#extension GL_ARB_shader_texture_lod : enable

uniform sampler2D texture;

varying vec4 color;
varying vec2 texCoord;

void main() {
    gl_FragData[0] = texture2DLod(texture, texCoord, 0.75) * color;
}