#version 120
#include "lib/settings.glsl"

uniform sampler2D lightmap;
uniform mat4 shadowModelViewInverse;

varying vec4 color;
varying vec2 texCoord;

void main() {
    vec3 positionPS = (shadowModelViewInverse * gl_ModelViewMatrix * gl_Vertex).xyz;
    vec3 positionCS = (-positionPS.xzy / MINIMAP_DISTANCE);
    positionCS.z = positionCS.z * 0.001 + 0.5;
    gl_Position = vec4(positionCS, 1.0);

    vec2 lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    color = gl_Color * texture2D(lightmap, lmcoord);

	texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}