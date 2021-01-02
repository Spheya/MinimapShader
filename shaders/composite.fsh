#version 120
#include "lib/settings.glsl"

uniform sampler2D colortex0;

uniform sampler2D shadowtex0;
uniform sampler2D shadowcolor0;

uniform float viewWidth;
uniform float viewHeight;

vec2 viewDimensions = vec2(viewWidth, viewHeight);

void main() {
    vec2 uv = gl_FragCoord.xy / viewDimensions;
    vec2 mapUv = ((viewDimensions - vec2(gl_FragCoord.x, gl_FragCoord.y) - vec2(8, 8)) / viewHeight) / MINIMAP_SIZE;
    mapUv.y = 1.0 - mapUv.y;

    vec2 remappedUv = mapUv * 2.0 - 1.0;

    float dist = length(remappedUv);
    float delta = fwidth(dist);
    float outlineAlpha = 1.0 - smoothstep(1.0 - delta, 1.0, dist);
    float innerOutlineAlpha = 1.0 - smoothstep(0.95 - delta, 0.95, dist);
    float mapAlpha = 1.0 - smoothstep(0.9 - delta, 0.9, dist);

    vec3 color = texture2D(colortex0, uv).rgb;
    color = mix(color, vec3(0.95), outlineAlpha);
    color = mix(color, vec3(0.75), innerOutlineAlpha);
    color = mix(color, texture2D(shadowcolor0, mapUv).rgb, mapAlpha);
    gl_FragData[0] = vec4(color, 1.0);
}