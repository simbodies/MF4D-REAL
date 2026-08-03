//
// Fragment shader that replaces white pixels with a selected color
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_replace_color;

void main() {
    vec4 tex_color = texture2D(gm_BaseTexture, v_vTexcoord);
    
    // Check if pixel is close to white (with tolerance)
    // This will match pure white (#ffffff) and very light colors
    if (tex_color.r > 0.98 && tex_color.g > 0.98 && tex_color.b > 0.98) {
        gl_FragColor = u_replace_color;
    } else {
        gl_FragColor = tex_color;
    }
}